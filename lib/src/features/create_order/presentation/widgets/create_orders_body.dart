part of '../imports/presentation-imports.dart';

class CreateOrdersBody extends StatelessWidget {
  const CreateOrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CreateOrdersCubit>();
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: AppPadding.pW20,
            vertical: AppPadding.pH20,
          ),
          child: Form(
            key: cubit.formKey,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppCircular.r12),
                border: Border.all(color: AppColors.inputBorder),
                boxShadow: [AppColors.containerShadow],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.pW20,
                  vertical: AppPadding.pH20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextFiled(
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.name,
                      hint: LocaleKeys.enterFullName,
                      title: LocaleKeys.clientName,
                      controller: cubit.customerNameController,
                      prefixIcon: const Icon(Icons.person_outline),
                      validator: (value) => Validators.validateName(
                        value,
                        fieldTitle: LocaleKeys.customerName,
                      ),
                    ),
                    SizedBox(height: AppSize.sH14),
                    CustomTextFiled(
                      title: LocaleKeys.clientPhoneNumber,
                      controller: cubit.phoneController,
                      textInputType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_outlined),
                      validator: (value) => Validators.validatePhone(
                        value,
                        fieldTitle: LocaleKeys.phoneNumber,
                      ),
                      hint: LocaleKeys.enterPhoneNumber,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: AppSize.sH14),
                    CustomTextFiled(
                      title: LocaleKeys.productName,
                      hint: LocaleKeys.pieceOrProductName,
                      controller: cubit.addressController,
                      validator: (value) => Validators.validateEmpty(
                        value,
                        fieldTitle: LocaleKeys.orderAddress,
                      ),
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: AppSize.sH14),
                    CustomTextFiled(
                      hint: LocaleKeys.amount,
                      title: LocaleKeys.numberOfPieces,
                      controller: cubit.numberOfPieces,
                      textInputType: TextInputType.number,
                      prefixIcon: const Icon(Icons.payments_outlined),
                      validator: (value) => Validators.validatePositiveInteger(
                        value,
                        fieldTitle: LocaleKeys.orderTotal,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: AppSize.sH14),
                    CustomTextFiled(
                      hint: LocaleKeys.orderTotal,
                      title: LocaleKeys.totalCost,
                      controller: cubit.totalController,
                      textInputType: TextInputType.number,
                      prefixIcon: const Icon(Icons.payments_outlined),
                      validator: (value) => Validators.validatePositiveInteger(
                        value,
                        fieldTitle: LocaleKeys.orderTotal,
                      ),
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: AppSize.sH14),
                    CustomTextFiled(
                      hint: LocaleKeys.deliveryPrice,
                      title: LocaleKeys.deliveryPrice,
                      controller: cubit.deliveryPrice,
                      textInputType: TextInputType.number,
                      prefixIcon: const Icon(Icons.payments_outlined),
                      validator: (value) => Validators.validatePositiveInteger(
                        value,
                        fieldTitle: LocaleKeys.orderTotal,
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: AppSize.sH24),
                    DefaultButton(
                      title: LocaleKeys.addOrder,
                      onTap: cubit.createOrder,
                      height: AppSize.sH48,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
