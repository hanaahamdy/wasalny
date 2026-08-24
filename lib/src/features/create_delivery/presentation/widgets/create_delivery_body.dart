part of '../imports/presentation_imports.dart';

class CreateDeliveryBody extends StatelessWidget {
  const CreateDeliveryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateDeliveryCubit>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: AppPadding.pW16,
        vertical: AppPadding.pH10,
      ),
      child: Column(
        children: [

          CustomTextFiled(
            prefixIcon: const Icon(Icons.person_outline_outlined),
            title: LocaleKeys.name,
            hint: LocaleKeys.enterFullName,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (val) => Validators.validateName(val),
            controller: cubit.fullNameController,
          ),
          CustomTextFiled(
            prefixIcon: const Icon(Icons.phone_outlined),
            title: LocaleKeys.phoneNumberOrEmail,
            hint: LocaleKeys.enterPhoneNumberOrEmail,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: (val) => Validators.validateEmpty(val),
            controller: cubit.phoneOrEmailController,
          ),
          CustomTextFiled(
            prefixIcon: const Icon(Icons.lock_outline, color: AppColors.grey2),
            suffixIcon: const Icon(
              Icons.visibility_off_outlined,
              color: AppColors.grey2,
            ),
            validator: (value) => Validators.validatePassword(
              value,
              fieldTitle: LocaleKeys.password,
            ),
            isPassword: true,
            title: LocaleKeys.password,
            hint: LocaleKeys.password,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: cubit.fullNameController,
          ),
          LocationTextField(
            onLocationSelected: (loc) {
              cubit.locationModel = loc;
              cubit.locationController.text = loc.descriptiveLocation;
            },
          ),
          20.szH,
          DefaultButton(title: LocaleKeys.addDelivery, onTap: () {}),
        ].joinWith(12.szH),
      ),
    );
  }
}
