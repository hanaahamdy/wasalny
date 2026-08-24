part of '../imports/presentation_imports.dart';

mixin CreateDeliveryControllers {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneOrEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  LocationModel? locationModel;
}
