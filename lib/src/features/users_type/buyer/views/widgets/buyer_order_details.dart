part of '../buyer_screen.dart';

class BuyerOrderDetailsScreen extends StatefulWidget {
  const BuyerOrderDetailsScreen({super.key});
  @override
  State<BuyerOrderDetailsScreen> createState() =>
      _BuyerOrderDetailsScreenState();
}

class _BuyerOrderDetailsScreenState extends State<BuyerOrderDetailsScreen> {
  final _viewModel = BuyerViewModel();
  final _formKey = GlobalKey<FormState>();
  final _clientController = TextEditingController();
  final List<_CategoryInput> _categories = [_CategoryInput()];
  double get _total => _categories.fold(0, (sum, item) => sum + item.total);

  @override
  void dispose() {
    _viewModel.dispose();
    _clientController.dispose();
    for (final item in _categories) {
      item.dispose();
    }
    super.dispose();
  }

  void _removeCategory(int index) {
    if (_categories.length == 1) return;
    setState(() => _categories.removeAt(index).dispose());
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _viewModel.addOrder(
      clientName: _clientController.text.trim(),
      categories: _categories
          .map(
            (item) => WorkflowCategory(
              name: item.name.text.trim(),
              count: int.parse(item.count.text),
              unitPrice: double.parse(item.price.text),
            ),
          )
          .toList(),
    );
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(LocaleKeys.workflowOrderSent)));
  }

  @override
  Widget build(BuildContext context) => WorkflowPage(
    title: LocaleKeys.workflowCategoryOrder,
    child: Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.pW20,
          vertical: AppPadding.pH20,
        ),
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
                  title: LocaleKeys.workflowClientName,
                  hint: LocaleKeys.workflowClientName,
                  controller: _clientController,
                  textInputType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  prefixIcon: const Icon(Icons.person_outline),
                  validator: _required,
                ),
                SizedBox(height: AppSize.sH14),
                ...List.generate(
                  _categories.length,
                  (index) => _CategoryEditor(
                    index: index,
                    input: _categories[index],
                    canRemove: _categories.length > 1,
                    onAdd: () =>
                        setState(() => _categories.add(_CategoryInput())),
                    onChanged: () => setState(() {}),
                    onRemove: () => _removeCategory(index),
                  ),
                ),
                SizedBox(height: AppSize.sH14),
                Container(
                  padding: EdgeInsets.all(AppPadding.pW12),
                  decoration: BoxDecoration(
                    color: AppColors.fieldFillColor,
                    borderRadius: BorderRadius.circular(AppCircular.r10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.workflowTotalPrice,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        LocaleKeys.workflowAmountEgp(
                          amount: _total.toStringAsFixed(2),
                        ),
                        style: TextStyle(
                          color: AppColors.scenarioPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppSize.sH24),
                DefaultButton(
                  title: LocaleKeys.workflowSendOrder,
                  onTap: _submit,
                  gradient: AppColors.scenarioGradient,
                  height: AppSize.sH48,
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  String? _required(String? value) => value == null || value.trim().isEmpty
      ? LocaleKeys.workflowRequired
      : null;
}
