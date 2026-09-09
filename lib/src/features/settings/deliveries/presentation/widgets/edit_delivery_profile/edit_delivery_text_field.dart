part of '../../imports/presentation_imports.dart';

class EditDeliveryTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType keyboardType;

  const EditDeliveryTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.icon,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.main,
            fontSize: FontSizeManager.s11,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        SizedBox(height: AppSize.sH6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          style: TextStyle(
            color: AppColors.main,
            fontSize: FontSizeManager.s11,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: AppColors.grey2, size: AppSize.sH18),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              horizontal: AppPadding.pW12,
              vertical: AppPadding.pH10,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppCircular.r12),
              borderSide: const BorderSide(color: AppColors.inputBorder),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppCircular.r12),
              borderSide: BorderSide(color: AppColors.scenarioPrimary),
            ),
          ),
        ),
      ],
    );
  }
}
