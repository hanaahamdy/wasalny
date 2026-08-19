part of '../../imports/view_imports.dart';

class ForgotPasswordCubit extends AsyncCubit<String?> {
  ForgotPasswordCubit() : super(null);

  Future<void> requestCode(
    ResetPasswordParams params, {
    required bool byEmail,
  }) async {
    if (!params.validate()) return;
    final loginValue = byEmail
        ? params.emailController.text.trim()
        : params.phoneController.text.trim();

    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<String?>(
          api: ApiConstants.forgetSendCode,
          body: {
            'login_value': loginValue,
            if (!byEmail)
              'country_code': params.countryCode.replaceFirst('+', ''),
          },
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) {
            final response = Map<String, dynamic>.from(json as Map);
            final data = response['data'];
            return data is Map ? data['token']?.toString() : null;
          },
        ),
      ),
      successEmitter: (token) async {
        if (token?.isNotEmpty != true) return;
        injector<NetworkService>().setToken(token!);
        await Go.to(
          OtpVerificationScreen(
            phone: loginValue,
            purpose: OtpPurpose.resetPassword,
          ),
        );
      },
    );
  }
}
