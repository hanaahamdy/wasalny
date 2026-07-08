part of '../../imports/view_imports.dart';

class _OtpBody extends StatefulWidget {
  final String phone;
  final OtpPurpose purpose;
  const _OtpBody({required this.phone, required this.purpose});

  @override
  State<_OtpBody> createState() => _OtpBodyState();
}

class _OtpBodyState extends State<_OtpBody> {
  static const int _resendDurationInSeconds = 59;
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();
  Timer? _timer;
  int _remainingSeconds = _resendDurationInSeconds;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final verifyState = context.watch<VerifyOtpCubit>().state;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW24,
          vertical: AppPadding.pH14,

        ),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _OtpHeader(
              title: widget.purpose.title,
              description: widget.purpose.description(widget.phone),
            ),
            AppSize.sH18.szH,
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppPadding.pW16,
                vertical: AppPadding.pH28,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: .06),
                    blurRadius: 55,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const _OtpIllustration(),
                  AppSize.sH28.szH,
                  CustomPinTextField(
                    controller: _pinController,
                    focusNode: _pinFocusNode,
                    hasError: verifyState.isError,
                  ),
                  AppSize.sH28.szH,
                  _OtpResendSection(
                    timerText: _timerText,
                    canResend: _remainingSeconds == ConstantManager.zero,
                    onResend: _resendCode,
                  ),
                  AppSize.sH30.szH,
                  LoadingButton(
                    title: LocaleKeys.confirm,
                    height: AppSize.sH56,
                    borderRadius: AppCircular.infinity,
                    color: AppColors.primary,
                    isDissabled: verifyState.isLoading,
                    onTap: _verify,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String get _timerText {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> _verify() async {
    final otp = _pinController.text.trim();
    if (otp.length != ConstantManager.pinCodeFieldsCount) {
      MessageUtils.showSnackBar(
        context: context,
        baseStatus: BaseStatus.error,
        message: LocaleKeys.emptyOtpRequired,
      );
      return;
    }

    await context.read<VerifyOtpCubit>().verify(phone: widget.phone, otp: otp);
  }

  Future<void> _resendCode() async {
    await context.read<ResendCodeCubit>().resend(
      phone: widget.phone,
      purpose: widget.purpose,
    );
    setState(() => _remainingSeconds = _resendDurationInSeconds);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= ConstantManager.zero) {
        timer.cancel();
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }
}

class _OtpHeader extends StatelessWidget {
  final String title;
  final String description;

  const _OtpHeader({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle().setMainTextColor.s20.semiBold),
        AppSize.sH10.szH,
        Text(
          description,
          style: const TextStyle()
              .setColor(const Color(0xFF474747))
              .s12
              .regular,
        ),
      ],
    );
  }
}

class _OtpIllustration extends StatelessWidget {
  const _OtpIllustration();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 220,
        width: 220,
        child: Image.asset(
          'assets/svg/base_svg/otp_verification.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class _OtpResendSection extends StatelessWidget {
  final String timerText;
  final bool canResend;
  final Future<void> Function() onResend;

  const _OtpResendSection({
    required this.timerText,
    required this.canResend,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          timerText,
          textDirection: TextDirection.ltr,
          style: const TextStyle()
              .setColor(const Color(0xFF474747))
              .s16
              .regular,
        ),
        AppSize.sH12.szH,
        TextButton(
          onPressed: canResend ? onResend : null,
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size(AppSize.sW40, AppSize.sH24),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            LocaleKeys.didNotGetVerifyNumber,
            style: const TextStyle()
                .setColor(canResend ? const Color(0xFF474747) : AppColors.grey2)
                .s16
                .medium,
          ),
        ),
      ],
    );
  }
}
