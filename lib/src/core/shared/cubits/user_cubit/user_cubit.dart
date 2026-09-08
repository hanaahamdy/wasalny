import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../config/res/config_imports.dart';
import '../../../helpers/cache_service.dart';
import '../../../network/network_service.dart';
import '../../domain/repositories/user_repository.dart';
import '../../models/user_model.dart';
part 'user_state.dart';
part 'user_utils.dart';

const String _userKey = 'user';
const String _tokenKey = 'token';

@lazySingleton
class UserCubit extends Cubit<UserState> with UserUtils {
  UserCubit() : super(UserState.initial());

  Future<void> setUserLoggedIn({
    required UserModel user,
    required String token,
  }) async {
    await Future.wait([_saveUser(user), _saveToken(token)]);
    injector<NetworkService>().setToken(token);
    emit(state.copyWith(userModel: user, userStatus: UserStatus.loggedIn));
  }

  Future<void> logout() async {
    await Future.wait([
      CacheStorage.delete(_userKey),
      SecureStorage.delete(_tokenKey),
    ]);
    _clearUser();
    emit(state.copyWith(userStatus: UserStatus.loggedOut));
  }

  Future<void> updateToken(String token) async {
    _saveToken(token);
  }

  Future<void> updateUser(UserModel user) async {
    await _saveUser(user);
    emit(state.copyWith(userModel: user));
  }

  Future<UserModel?> refreshProfile() async {
    try {
      final result = await injector<UserRepository>().fetchProfile();
      final user = result.tryGetSuccess();
      if (user == null) return null;
      await updateUser(user.copyWith(accessToken: state.userModel.accessToken));
      return user;
    } catch (_) {
      return null;
    }
  }

  Future<bool> init() async {
    final Map<String, dynamic>? userMap = CacheStorage.read(
      _userKey,
      isDecoded: true,
    );
    final token = await SecureStorage.read(_tokenKey);
    final savedToken = token?.trim();
    log('userMap $userMap, token $token');
    if (savedToken?.isNotEmpty == true && userMap != null) {
      injector<NetworkService>().setToken(savedToken!);
      emit(
        state.copyWith(
          userModel: UserModel.fromJson(userMap),
          userStatus: UserStatus.loggedIn,
        ),
      );
      return true;
    }
    return false;
  }

  void _clearUser() {
    injector<NetworkService>().removeToken();
    emit(UserState.initial());
  }

  UserModel get user => state.userModel;
  static UserCubit get instance => injector<UserCubit>();

  bool get isUserLoggedIn => state.userStatus == UserStatus.loggedIn;
}
