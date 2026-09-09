part of '../buyer_screen.dart';

class _CategoryEditor extends StatelessWidget {
  final int index;
  final _CategoryInput input;
  final bool canRemove;
  final VoidCallback onAdd;
  final VoidCallback onChanged;
  final VoidCallback onRemove;
  const _CategoryEditor({
    required this.index,
    required this.input,
    required this.canRemove,
    required this.onAdd,
    required this.onChanged,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.only(bottom: AppPadding.pH14),
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
              if (canRemove)
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: AppColors.error,
                ),
              if (index == 0)
                IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.add_circle_outline),
                  color: AppColors.scenarioPrimary,
                ),
            ],
          ),
          CustomTextFiled(
            title: LocaleKeys.workflowCategoryName,
            hint: LocaleKeys.workflowCategoryName,
            controller: input.name,
            textInputType: TextInputType.text,
            textInputAction: TextInputAction.next,
            validator: (value) => value == null || value.trim().isEmpty
                ? LocaleKeys.workflowRequired
                : null,
          ),
          SizedBox(height: AppSize.sH14),
          Row(
            children: [
              Expanded(
                child: CustomTextFiled(
                  title: LocaleKeys.workflowCount,
                  hint: LocaleKeys.workflowCount,
                  controller: input.count,
                  onChanged: (_) => onChanged(),
                  textInputType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => (int.tryParse(value ?? '') ?? 0) < 1
                      ? LocaleKeys.workflowInvalid
                      : null,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextFiled(
                  title: LocaleKeys.workflowUnitPrice,
                  hint: LocaleKeys.workflowUnitPrice,
                  controller: input.price,
                  onChanged: (_) => onChanged(),
                  textInputType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textInputAction: TextInputAction.done,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  validator: (value) => (double.tryParse(value ?? '') ?? 0) <= 0
                      ? LocaleKeys.workflowInvalid
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
