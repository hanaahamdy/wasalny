part of '../imports/presentation_imports.dart';

class DeliveryHomeScreen extends StatelessWidget {
  const DeliveryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: DeliveryHomeBody(),
    );
  }
}
