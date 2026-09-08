part of '../imports/presentation_imports.dart';

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
                    BlocBuilder<CreateOrdersCubit, CreateOrdersState>(
                      buildWhen: (previous, current) =>
                          previous.itemCount != current.itemCount,
                      builder: (context, state) =>
                          _OrderItemsSection(cubit: cubit),
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
                      controller: cubit.deliveryPriceController,
                      textInputType: TextInputType.number,
                      prefixIcon: const Icon(Icons.payments_outlined),
                      validator: (value) => Validators.validatePositiveInteger(
                        value,
                        fieldTitle: LocaleKeys.orderTotal,
                      ),
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: AppSize.sH24),
                    BlocBuilder<CreateOrdersCubit, CreateOrdersState>(
                      buildWhen: (previous, current) =>
                          previous.isLoading != current.isLoading,
                      builder: (context, state) => DefaultButton(
                        title: LocaleKeys.addOrder,
                        onTap: state.isLoading ? null : cubit.createOrder,
                        disabled: state.isLoading,
                        customChild: state.isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.white,
                              )
                            : null,
                        height: AppSize.sH48,
                      ),
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

class _OrderItemsSection extends StatelessWidget {
  final CreateOrdersCubit cubit;

  const _OrderItemsSection({required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(cubit.orderItems.length, (index) {
        final item = cubit.orderItems[index];

        return Padding(
          padding: EdgeInsets.only(
            bottom: index == cubit.orderItems.length - 1 ? 0 : AppPadding.pH14,
          ),
          child: Container(
            padding: EdgeInsets.all(AppPadding.pW12),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppCircular.r10),
              border: Border.all(color: AppColors.inputBorder),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (index > 0)
                      IconButton(
                        onPressed: () => cubit.removeOrderItem(index),
                        icon: const Icon(Icons.remove_circle_outline),
                        color: AppColors.error,
                      ),
                    if (index == 0)
                      IconButton(
                        onPressed: cubit.addOrderItem,
                        icon: const Icon(Icons.add_circle_outline),
                        color: AppColors.authTabSelected,
                      ),
                  ],
                ),
                CustomTextFiled(
                  title: LocaleKeys.productName,
                  hint: LocaleKeys.pieceOrProductName,
                  controller: item.productName,
                  validator: (value) => Validators.validateEmpty(
                    value,
                    fieldTitle: LocaleKeys.productName,
                  ),
                  textInputType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: AppSize.sH14),
                CustomTextFiled(
                  hint: LocaleKeys.pricing,
                  title: LocaleKeys.pricing,
                  controller: item.price,
                  textInputType: TextInputType.number,
                  prefixIcon: const Icon(Icons.payments_outlined),
                  validator: (value) => Validators.validatePositiveInteger(
                    value,
                    fieldTitle: LocaleKeys.pricing,
                  ),
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: AppSize.sH14),
                CustomTextFiled(
                  hint: LocaleKeys.amount,
                  title: LocaleKeys.numberOfPieces,
                  controller: item.quantity,
                  textInputType: TextInputType.number,
                  prefixIcon: const Icon(Icons.inventory_2_outlined),
                  validator: (value) => Validators.validatePositiveInteger(
                    value,
                    fieldTitle: LocaleKeys.numberOfPieces,
                  ),
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
