import 'dart:io';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../config/language/locale_keys.g.dart';
import '../../config/language/languages.dart';
import '../../config/res/config_imports.dart';
import '../error/exceptions.dart';
import '../helpers/cache_service.dart';
import '../navigation/navigator.dart';
import '../shared/models/base_model.dart';
import 'backend_configuation.dart';
import 'configuration_interceptor.dart';
import 'extensions.dart';
import 'network_request.dart';
import 'network_service.dart';
import 'un_authenticated_interceptor.dart';

@LazySingleton(as: NetworkService)
class DioService implements NetworkService {
  late final Dio _dio;

  DioService() {
    _dio = Dio()
      ..options.connectTimeout = const Duration(
        milliseconds: ConstantManager.connectTimeoutDuration,
      )
      ..options.sendTimeout = const Duration(
        milliseconds: ConstantManager.sendTimeoutDuration,
      )
      ..options.receiveTimeout = const Duration(
        milliseconds: ConstantManager.receiveTimeoutDuration,
      )
      ..options.responseType = ResponseType.json;

    if (BackendConfiguation.type.isPhp) {
      _dio.interceptors.add(ConfigurationInterceptor());
    }

    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          error: true,
          compact: true,
          maxWidth: 100,
        ),
      );
      _dio.interceptors.add(UnAuthenticatedInterceptor.instance);
    }
  }

  Future<String> getBaseUrl() async {
    return await SecureStorage.read(SecureLocalVariableKeys.baseUrlKey) ?? '';
  }

  @override
  Future<void> updateBaseUrl() async {
    final baseUrl = await getBaseUrl();
    _dio.options.baseUrl = baseUrl;
  }

  @override
  void setToken(String token) {
    _dio.options.headers[HttpHeaders.authorizationHeader] =
        'Bearer ${token.replaceAll('Bearer', '').trim()}';
    changeLocale();
  }

  @override
  void removeToken() {
    _dio.options.headers.remove(HttpHeaders.authorizationHeader);
  }

  @override
  void changeLocale({String? locale}) {
    _dio.options.headers[HttpHeaders.acceptLanguageHeader] =
        locale ?? Go.context.locale.languageCode;
    _dio.options.headers['lang'] = locale ?? Go.context.locale.languageCode;
  }

  Future<Map<String, dynamic>> publicHeaders() async {
    return {"lang": Languages.currentLanguage.languageCode};
  }

  @override
  Future<BaseModel<Model>> callApi<Model>(
    NetworkRequest networkRequest, {
    Model Function(dynamic json)? mapper,
  }) async {
    try {
      final publicHeadersValue = await publicHeaders();
      await networkRequest.prepareRequestData();
      final response = await _dio.request(
        networkRequest.path,
        data: networkRequest.hasBodyAndProgress()
            ? networkRequest.isFormData
                  ? FormData.fromMap(networkRequest.body!)
                  : networkRequest.body
            : networkRequest.body,
        queryParameters: networkRequest.queryParameters,
        onSendProgress: networkRequest.hasBodyAndProgress()
            ? networkRequest.onSendProgress
            : null,
        onReceiveProgress: networkRequest.hasBodyAndProgress()
            ? networkRequest.onReceiveProgress
            : null,
        options: Options(
          method: networkRequest.asString(),
          headers: networkRequest.headers != null
              ? {...networkRequest.headers!, ...publicHeadersValue}
              : publicHeadersValue,
        ),
      );
      final statusCode = response.statusCode;
      if (statusCode != null) {
        networkRequest.onResponseStatus?.call(statusCode);
      }
      if (mapper != null) {
        return BaseModel.fromJson(response.data, jsonToModel: mapper);
      } else {
        return BaseModel.fromJson(response.data);
      }
    } on DioException catch (e) {
      return _handleError(e);
    }
  }

  Never _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        throw NoInternetConnectionException(LocaleKeys.checkInternet);
      case DioExceptionType.badResponse:
        final message = _extractErrorMessage(error.response?.data);
        switch (error.response?.statusCode) {
          case HttpStatus.nonAuthoritativeInformation:
            throw NeedActiveException(message ?? LocaleKeys.verifyAccount);
          case HttpStatus.badRequest:
          case HttpStatus.unprocessableEntity:
            throw BadRequestException(message ?? LocaleKeys.badRequest);
          case HttpStatus.unauthorized:
            throw UnauthorizedException(message ?? LocaleKeys.badRequest);
          case HttpStatus.locked:
            throw BlockedException(message ?? LocaleKeys.badRequest);
          case HttpStatus.forbidden:
            throw NeedActiveException(message ?? LocaleKeys.badRequest);
          case HttpStatus.notFound:
            throw NotFoundException(message ?? LocaleKeys.notFound);
          case HttpStatus.conflict:
            throw ConflictException(message ?? LocaleKeys.serverError);
          case HttpStatus.internalServerError:
            throw InternalServerErrorException(
              message ?? LocaleKeys.serverError,
            );
          default:
            throw ServerException(message ?? LocaleKeys.serverError);
        }
      case DioExceptionType.cancel:
        throw ServerException(LocaleKeys.intenetWeakness);
      case DioExceptionType.unknown:
        throw ServerException(
          _extractErrorMessage(error.response?.data) ??
              LocaleKeys.exceptionError,
        );
      default:
        throw ServerException(LocaleKeys.exceptionError);
    }
  }

  String? _extractErrorMessage(dynamic responseData) {
    if (responseData is! Map) return null;

    final errors = responseData['errors'];
    if (errors is Map) {
      final messages = errors.values
          .expand<String>((value) {
            if (value is List) {
              return value.whereType<String>();
            }
            return value is String ? [value] : const <String>[];
          })
          .where((message) => message.trim().isNotEmpty)
          .toList();
      if (messages.isNotEmpty) return messages.join('\n');
    }

    final message = responseData['message'];
    return message is String && message.trim().isNotEmpty ? message : null;
  }
}
