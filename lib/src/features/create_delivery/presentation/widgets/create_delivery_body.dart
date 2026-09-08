part of '../imports/presentation_imports.dart';

class CreateDeliveryBody extends StatelessWidget {
  const CreateDeliveryBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateDeliveryCubit>(context);
    return BlocConsumer<CreateDeliveryCubit, CreateDeliveryState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          (!previous.isSuccess && current.isSuccess),
      listener: (context, state) {
        if (state.errorMessage != null) {
          MessageUtils.showSnackBar(
            context: context,
            baseStatus: BaseStatus.error,
            message: state.errorMessage!,
          );
        } else if (state.isSuccess) {
          if (state.successMessage?.isNotEmpty == true) {
            MessageUtils.showSnackBar(
              context: context,
              baseStatus: BaseStatus.success,
              message: state.successMessage!,
            );
          }
          Go.back(true);
        }
      },
      builder: (context, state) => SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW16,
          vertical: AppPadding.pH10,
        ),
        child: Form(
          key: cubit.formKey,
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
                prefixIcon: const Icon(Icons.email_outlined),
                title: LocaleKeys.email,
                hint: LocaleKeys.enterTheEmail,
                textInputType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (val) =>
                    Validators.validateEmail(val, fieldTitle: LocaleKeys.email),
                controller: cubit.emailController,
              ),
              CustomTextFiled(
                prefixIcon: const Icon(
                  Icons.lock_outline,
                  color: AppColors.grey2,
                ),
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
                textInputType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                controller: cubit.passwordController,
                onSubmitted: (_) => cubit.createDelivery(),
              ),
              LocationTextField(
                onLocationSelected: (loc) {
                  cubit.locationModel = loc;
                  cubit.locationController.text = loc.descriptiveLocation;
                },
              ),
              20.szH,
              DefaultButton(
                title: LocaleKeys.addDelivery,
                onTap: state.isLoading ? null : cubit.createDelivery,
                disabled: state.isLoading,
                customChild: state.isLoading
                    ? const CircularProgressIndicator(color: AppColors.white)
                    : null,
              ),
            ].joinWith(12.szH),
          ),
        ),
      ),
    );
  }
}
