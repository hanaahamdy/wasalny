import 'package:flutter/material.dart';
import '../../../../workflow/models/workflow_order.dart';
import '../../../../../config/language/locale_keys.g.dart';

class PackingSlipDialog extends StatelessWidget {
  final WorkflowOrder order;

  const PackingSlipDialog({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.print_outlined),
          const SizedBox(width: 8),
          Text(LocaleKeys.workflowPackingSlip),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(LocaleKeys.workflowOrderNumber(order.id)),
            Text(LocaleKeys.workflowClientValue(order.clientName)),
            const Divider(),
            ...order.categories.map(
              (item) => Text(
                LocaleKeys.workflowItemCount(item.name, item.count),
              ),
            ),
            const Divider(),
            Text(
              LocaleKeys.workflowTotalValue(
                order.totalPrice.toStringAsFixed(2),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(LocaleKeys.workflowDone),
        ),
      ],
    );
  }
}
