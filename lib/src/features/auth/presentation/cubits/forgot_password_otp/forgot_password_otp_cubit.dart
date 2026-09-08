part of '../../imports/view_imports.dart';

class ForgotPasswordOtpCubit extends Cubit<ForgotPasswordOtpState>
    with ForgotPasswordOtpMixin {
  static const _countdownSeconds = 60;
  final AuthRepository _repository;
  final String email;
  Timer? _timer;

  ForgotPasswordOtpCubit({required this.email, AuthRepository? repository})
    : _repository = repository ?? injector<AuthRepository>(),
      super(const ForgotPasswordOtpState()) {
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    emit(state.copyWith(secondsLeft: _countdownSeconds));
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.secondsLeft <= 1) {
        timer.cancel();
        emit(state.copyWith(secondsLeft: 0));
      } else {
        emit(state.copyWith(secondsLeft: state.secondsLeft - 1));
      }
    });
  }

  void validateOtp() {
    final otp = otpController.text.trim();
    if (otp.length != ConstantManager.pinCodeFieldsCount) {
      emit(
        state.copyWith(
          hasError: true,
          isSuccess: false,
          errorMessage: LocaleKeys.emptyOtpRequired,
        ),
      );
      return;
    }
    emit(state.copyWith(hasError: false, isSuccess: true, clearError: true));
  }

  Future<void> resend() async {
    if (state.secondsLeft > 0 || state.isResending) return;
    emit(
      state.copyWith(isResending: true, clearError: true, clearSuccess: true),
    );
    final result = await _repository.forgotPassword(email);
    result.when(
      (message) {
        otpController.clear();
        emit(state.copyWith(isResending: false, successMessage: message));
        _startTimer();
      },
      (failure) => emit(
        state.copyWith(isResending: false, errorMessage: failure.message),
      ),
    );
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
