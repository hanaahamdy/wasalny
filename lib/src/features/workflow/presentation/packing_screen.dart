import 'package:flutter/material.dart';
import '../domain/workflow_order.dart';
import 'widgets/workflow_widgets.dart';

class PackingScreen extends StatelessWidget {
  const PackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkflowPage(
      title: 'Packing',
      child: ListenableBuilder(
        listenable: WorkflowStore.instance,
        builder: (context, _) {
          final orders = WorkflowStore.instance.orders
              .where((order) => order.status == WorkflowOrderStatus.readyForPacking)
              .toList();
          if (orders.isEmpty) return const EmptyWorkflow('No approved orders are ready for packing.');
          return ListView(
            padding: const EdgeInsets.all(16),
            children: orders
                .map(
                  (order) => WorkflowOrderCard(
                    order: order,
                    action: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showPackingSlip(context, order),
                            icon: const Icon(Icons.print_outlined),
                            label: const Text('Print'),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              WorkflowStore.instance.sendToAliaa(order.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Prepared and sent to Aliaa.')),
                              );
                            },
                            icon: const Icon(Icons.forward_to_inbox_outlined),
                            label: const Text('Send to Aliaa'),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }

  void _showPackingSlip(BuildContext context, WorkflowOrder order) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(children: [Icon(Icons.print_outlined), SizedBox(width: 8), Text('Packing slip')]),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Order #${order.id}'),
              Text('Client: ${order.clientName}'),
              const Divider(),
              ...order.categories.map((item) => Text('${item.name}  ×  ${item.count}')),
              const Divider(),
              Text('Total: ${order.totalPrice.toStringAsFixed(2)} EGP'),
            ],
          ),
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Done'))],
      ),
    );
  }
}
