part of '../../imports/view_imports.dart';

class RegisterVerifyOtpCubit extends VerifyOtpCubit {
  @override
  Future<void> verify({required String phone, required String otp}) async {
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<BaseModel?>(
          api: ApiConstants.verifyOtp,
          body: {'code': otp},
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) {
            final response = Map<String, dynamic>.from(json as Map);
            final data = response['data'];
            return BaseModel<UserModel?>(
              message: response['message']?.toString() ?? '',
              key: response['key']?.toString() ?? '',
              data: data is Map
                  ? UserModel.fromJson(Map<String, dynamic>.from(data))
                  : null,
            );
          },
        ),
      ),
      successEmitter: _handleAuthenticatedUser,
    );
  }
}
