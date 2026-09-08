part of '../imports/presentation_imports.dart';

mixin CreateDeliveryControllers on Cubit<CreateDeliveryState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  LocationModel? locationModel;

  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    locationController.dispose();
    return super.close();
  }
}
