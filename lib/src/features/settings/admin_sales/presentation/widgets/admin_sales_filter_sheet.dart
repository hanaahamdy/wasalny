part of '../imports/presentation_imports.dart';

class AdminSalesFilterSheet extends StatefulWidget {
  const AdminSalesFilterSheet({super.key});

  static Future<AdminSalesFilter?> show(BuildContext context) async {
    final result = await showDefaultBottomSheet(
      context: context,
      child: const AdminSalesFilterSheet(),
    );
    return result as AdminSalesFilter?;
  }

  @override
  State<AdminSalesFilterSheet> createState() => _AdminSalesFilterSheetState();
}

class _AdminSalesFilterSheetState extends State<AdminSalesFilterSheet> {
  final _customerController = TextEditingController();
  final _fromDateController = TextEditingController();
  final _toDateController = TextEditingController();
  DateTime? _fromDate;
  DateTime? _toDate;

  @override
  void dispose() {
    _customerController.dispose();
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppPadding.pW2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                borderRadius: BorderRadius.circular(AppCircular.r8),
                child: Container(
                  width: AppSize.sW30,
                  height: AppSize.sW30,
                  decoration: BoxDecoration(
                    color: AppColors.error.withValues(alpha: .1),
                    borderRadius: BorderRadius.circular(AppCircular.r8),
                  ),
                  child: Icon(
                    Icons.close,
                    color: AppColors.error,
                    size: AppSize.sH16,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  LocaleKeys.salesFilter,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: AppColors.main,
                    fontSize: FontSizeManager.s16,
                    fontWeight: FontWeightManager.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppSize.sH12),
          CustomTextFiled(
            title: LocaleKeys.customer,
            hint: LocaleKeys.customerName,
            controller: _customerController,
            textInputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            validator: null,
            readOnly: true,
            hasBorder: true,
            fillColor: AppColors.white,
            prefixIcon: const Icon(
              Icons.person_outline,
              color: AppColors.grey2,
            ),
            suffixIcon: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.grey2,
            ),
            onTap: _selectCustomer,
          ),
          SizedBox(height: AppSize.sH12),
          CustomTextFiled(
            title: LocaleKeys.fromDate,
            hint: 'YYYY-MM-DD',
            controller: _fromDateController,
            textInputType: TextInputType.datetime,
            textInputAction: TextInputAction.next,
            validator: null,
            readOnly: true,
            hasBorder: true,
            fillColor: AppColors.white,
            onTap: () => _pickDate(isFromDate: true),
          ),
          SizedBox(height: AppSize.sH12),
          CustomTextFiled(
            title: LocaleKeys.toDate,
            hint: 'YYYY-MM-DD',
            controller: _toDateController,
            textInputType: TextInputType.datetime,
            textInputAction: TextInputAction.done,
            validator: null,
            readOnly: true,
            hasBorder: true,
            fillColor: AppColors.white,
            onTap: () => _pickDate(isFromDate: false),
          ),
          SizedBox(height: AppSize.sH16),
          AdminSalesFilterButton(onTap: _applyFilter),
          SizedBox(height: AppSize.sH4),
        ],
      ),
    );
  }

  void _applyFilter() {
    Navigator.of(context).pop(
      AdminSalesFilter(
        customerName: _customerController.text.trim().isEmpty
            ? null
            : _customerController.text.trim(),
        fromDate: _fromDate,
        toDate: _toDate,
      ),
    );
  }

  Future<void> _selectCustomer() async {
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final selectedCustomer = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        AppPadding.pW12,
        overlay.size.height / 2,
        AppPadding.pW12,
        0,
      ),
      items: AdminSaleModel.samples
          .map((sale) => sale.customerName)
          .toSet()
          .map(
            (customer) => PopupMenuItem(value: customer, child: Text(customer)),
          )
          .toList(),
    );
    if (selectedCustomer != null) {
      _customerController.text = selectedCustomer;
    }
  }

  Future<void> _pickDate({required bool isFromDate}) async {
    final initialDate = isFromDate
        ? _fromDate ?? DateTime.now()
        : _toDate ?? _fromDate ?? DateTime.now();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (selectedDate == null || !mounted) return;
    setState(() {
      if (isFromDate) {
        _fromDate = selectedDate;
        _fromDateController.text = _formatDate(selectedDate);
        if (_toDate != null && _toDate!.isBefore(selectedDate)) {
          _toDate = selectedDate;
          _toDateController.text = _formatDate(selectedDate);
        }
      } else {
        _toDate = selectedDate;
        _toDateController.text = _formatDate(selectedDate);
      }
    });
  }

  String _formatDate(DateTime date) {
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '${date.year}-$month-$day';
  }
}
