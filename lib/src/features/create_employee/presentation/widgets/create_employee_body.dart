part of '../imports/presentation_imports.dart';

class CreateEmployeeBody extends StatelessWidget {
  const CreateEmployeeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<CreateEmployeeCubit>(context);
    return BlocConsumer<CreateEmployeeCubit, CreateEmployeeState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          (!previous.isSuccess && current.isSuccess),
      listener: (context, state) async {
        if (state.errorMessage != null) {
          MessageUtils.showSnackBar(
            context: context,
            baseStatus: BaseStatus.error,
            message: state.errorMessage!,
          );
        } else if (state.isSuccess) {
          await successDialog(
            context: context,
            title: LocaleKeys.employeeAddedSuccessfully,
            afterSuccess: () => Go.back(true),
          );
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
                prefixIcon: const Icon(Icons.phone_outlined),
                title: LocaleKeys.phoneNumber,
                hint: LocaleKeys.pleaseEnterYourPhoneNumber,
                textInputType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                validator: (value) => Validators.validatePhone(
                  value,
                  fieldTitle: LocaleKeys.phoneNumber,
                ),
                controller: cubit.phoneController,
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
                onSubmitted: (_) => cubit.createEmployee(),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.employeeType,
                    style: const TextStyle().setMainTextColor.s13.medium,
                  ),
                  8.szH,
                  DropdownButtonFormField<EmployeeType>(
                    initialValue: state.employeeType,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.selectEmployeeType,
                      prefixIcon: const Icon(Icons.badge_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppCircular.r10),
                      ),
                    ),
                    items: EmployeeType.values
                        .map(
                          (type) => DropdownMenuItem<EmployeeType>(
                            value: type,
                            child: Text(_employeeTypeLabel(type)),
                          ),
                        )
                        .toList(),
                    onChanged: cubit.selectEmployeeType,
                    validator: (value) =>
                        value == null ? LocaleKeys.fillField : null,
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  LocaleKeys.orderCycle,
                  style: const TextStyle().setMainTextColor.s13.medium,
                ),
              ),
              RadioGroup<EmployeeCycle>(
                groupValue: state.cycle,
                onChanged: cubit.selectCycle,
                child: Column(
                  children: [
                    RadioListTile<EmployeeCycle>(
                      value: EmployeeCycle.cycleOne,
                      title: Text(LocaleKeys.cycleOne),
                      activeColor: AppColors.scenarioPrimary,
                    ),
                    RadioListTile<EmployeeCycle>(
                      value: EmployeeCycle.cycleTwo,
                      title: Text(LocaleKeys.cycleTwo),
                      activeColor: AppColors.scenarioPrimary,
                    ),
                  ],
                ),
              ),
              20.szH,
              DefaultButton(
                title: LocaleKeys.addEmployee,
                onTap: state.isLoading ? null : cubit.createEmployee,
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

  String _employeeTypeLabel(EmployeeType type) => switch (type) {
    EmployeeType.delivery => LocaleKeys.employeeDelivery,
    EmployeeType.buyer => LocaleKeys.employeeBuyer,
    EmployeeType.packer => LocaleKeys.employeePacker,
    EmployeeType.alia => LocaleKeys.employeeAliaa,
  };
}
