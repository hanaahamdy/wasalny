part of '../imports/presentation_imports.dart';

class DeliveryHomeScreen extends StatelessWidget {
  final HomeModel data;

  const DeliveryHomeScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: DeliveryHomeBody(data: data),
    );
  }
}
