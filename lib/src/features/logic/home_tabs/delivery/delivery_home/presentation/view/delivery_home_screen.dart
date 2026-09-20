part of '../imports/presentation_imports.dart';

class DeliveryHomeScreen extends StatelessWidget {
  const DeliveryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DeliveryHomeCubit()..fetchHome(),
      child: BlocListener<DeliveryHomeCubit, RequestState<DeliveryHomeModel?>>(
        listenWhen: (previous, current) =>
            previous.errorMessage != current.errorMessage &&
            current.errorMessage != null,
        listener: (context, state) => MessageUtils.showSnackBar(
          context: context,
          baseStatus: BaseStatus.error,
          message: state.errorMessage!,
        ),
        child: const AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          child: DeliveryHomeBody(),
        ),
      ),
    );
  }
}
