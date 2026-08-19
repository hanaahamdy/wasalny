part of '../../imports/view_imports.dart';

class RegisterCubit extends AsyncCubit<AuthResponse?> {
  RegisterCubit() : super(null);

  Future<void> register(SignUpParams params) async {
    if (!params.validate()) return;
    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<AuthResponse>(
          api: ApiConstants.register,
          body: params.toJson(),
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          mapper: (json) =>
              AuthResponse.fromJson(Map<String, dynamic>.from(json as Map)),
        ),
      ),
      successEmitter: (response) {
        final activationToken = response?.data?.token ?? '';
        if (activationToken.isEmpty) {
          setError(
            errorMessage: response?.message.isNotEmpty == true
                ? response!.message
                : LocaleKeys.serverError,
            showToast: true,
          );
          return;
        }
        injector<NetworkService>().setToken(activationToken);
        Go.to(
          OtpVerificationScreen(
            phone: response?.data?.phone.isNotEmpty == true
                ? response!.data!.phone
                : params.phoneController.text.trim(),
            purpose: OtpPurpose.register,
          ),
        );
      },
    );
  }
}
