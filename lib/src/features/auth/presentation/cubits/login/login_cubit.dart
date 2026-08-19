part of '../../imports/view_imports.dart';

class LoginCubit extends AsyncCubit<AuthResponse?> {
  LoginCubit() : super(null);

  Future<void> login(LoginParams params) async {
    if (!params.validate()) return;
    int? responseStatusCode;

    await executeAsync(
      operation: () => baseCrudUseCase.call(
        CrudBaseParams<AuthResponse>(
          api: ApiConstants.login,
          body: params.toJson(),
          httpRequestType: HttpRequestType.post,
          isFromData: true,
          onResponseStatus: (statusCode) => responseStatusCode = statusCode,
          mapper: (json) =>
              AuthResponse.fromJson(Map<String, dynamic>.from(json as Map)),
        ),
      ),
      showErrorToast: false,
    );
    if (responseStatusCode == 203) {
      final authData = state.data?.data;
      final activationToken = authData?.token ?? '';
      if (activationToken.isEmpty) {
        setError(
          errorMessage: state.data?.message.isNotEmpty == true
              ? state.data!.message
              : LocaleKeys.verifyAccount,
          showToast: true,
        );
        return;
      }
      injector<NetworkService>().setToken(activationToken);
      Go.to(
        OtpVerificationScreen(
          phone: authData?.phone.isNotEmpty == true
              ? authData!.phone
              : params.identifier,
          // A 203 means the account still needs the same activation flow used
          // immediately after registration.
          purpose: OtpPurpose.register,
        ),
      );
      return;
    }
    if (!state.isSuccess) {
      if (state.errorMessage != null) {
        MessageUtils.showSnackBar(
          message: state.errorMessage!,
          baseStatus: BaseStatus.error,
        );
      }
      return;
    }

    final response = state.data;
    final authData = response?.data;
    if (authData == null || authData.token.isEmpty) {
      setError(errorMessage: response?.message);
      return;
    }

    final fallbackUser = UserModel.initial().copyWith(
      id: authData.id,
      phoneNumber: authData.phone,
      token: authData.token,
    );
    await UserCubit.instance.setUserLoggedIn(
      user: fallbackUser,
      token: authData.token,
    );
    await UserCubit.instance.refreshProfile();
    Go.offAll(const HomeScreen());
  }
}
