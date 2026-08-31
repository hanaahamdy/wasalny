part of '../../imports/presentation_imports.dart';

class EditDeliveryProfileBody extends StatefulWidget {
  final DeliveryModel delivery;

  const EditDeliveryProfileBody({super.key, required this.delivery});

  @override
  State<EditDeliveryProfileBody> createState() =>
      _EditDeliveryProfileBodyState();
}

class _EditDeliveryProfileBodyState extends State<EditDeliveryProfileBody> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _locationController;
  File? _image;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.delivery.name);
    _phoneController = TextEditingController(text: widget.delivery.phone);
    _locationController = TextEditingController(text: widget.delivery.location);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW10,
        vertical: AppPadding.pH12,
      ),
      child: Column(
        children: [
          EditDeliveryTextField(
            label: LocaleKeys.name,
            controller: _nameController,
            icon: Icons.person_outline,
            keyboardType: TextInputType.name,
          ),
          SizedBox(height: AppSize.sH12),
          EditDeliveryTextField(
            label: LocaleKeys.phoneNumberOrEmail,
            controller: _phoneController,
            icon: Icons.phone_outlined,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: AppSize.sH12),
          EditDeliveryTextField(
            label: LocaleKeys.location,
            controller: _locationController,
            icon: Icons.location_on_outlined,
            keyboardType: TextInputType.streetAddress,
          ),
          SizedBox(height: AppSize.sH12),
          DeliveryImageUpload(image: _image, onTap: _selectImage),
          SizedBox(height: AppSize.sH16),
          DefaultButton(
            width: double.infinity,
            height: AppSize.sH45,
            title: LocaleKeys.saveChanges,
            onTap: () => Go.back(),
          ),
        ],
      ),
    );
  }

  Future<void> _selectImage() async {
    final image = await ImageHelper.getImageFromCameraOrDevice();
    if (image != null && mounted) setState(() => _image = image);
  }
}
