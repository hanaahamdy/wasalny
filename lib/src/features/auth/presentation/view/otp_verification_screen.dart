part of '../imports/view_imports.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String phone;
  final OtpPurpose purpose;
  final ProviderRegistrationType? registrationType;

  const OtpVerificationScreen({
    super.key,
    required this.phone,
    this.purpose = OtpPurpose.register,
    this.registrationType,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VerifyOtpCubit.fromPurpose(purpose)),
        BlocProvider(create: (_) => ResendCodeCubit()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: true,
        ),
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: _OtpBody(
            phone: phone,
            purpose: purpose,
            registrationType: registrationType,
          ),
        ),
      ),
    );
  }
}
