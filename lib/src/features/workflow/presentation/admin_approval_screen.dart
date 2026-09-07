import 'package:flutter/material.dart';
import '../domain/workflow_order.dart';
import 'widgets/workflow_widgets.dart';

class AdminApprovalScreen extends StatelessWidget {
  const AdminApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkflowPage(
      title: 'Buyer approvals',
      child: ListenableBuilder(
        listenable: WorkflowStore.instance,
        builder: (context, _) {
          final orders = WorkflowStore.instance.orders
              .where((order) => order.status == WorkflowOrderStatus.waitingAdmin)
              .toList();
          if (orders.isEmpty) return const EmptyWorkflow('No buyer requests are waiting for approval.');
          return ListView(
            padding: const EdgeInsets.all(16),
            children: orders
                .map(
                  (order) => WorkflowOrderCard(
                    order: order,
                    action: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          WorkflowStore.instance.approve(order.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Approved and sent to Packing.')),
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('Approve order and Live request'),
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
