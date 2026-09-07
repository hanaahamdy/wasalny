import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../domain/workflow_order.dart';
import 'widgets/workflow_widgets.dart';

class AliaaScreen extends StatelessWidget {
  const AliaaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WorkflowPage(
      title: 'Aliaa — client numbers',
      child: ListenableBuilder(
        listenable: WorkflowStore.instance,
        builder: (context, _) {
          final orders = WorkflowStore.instance.orders
              .where((order) => order.status == WorkflowOrderStatus.readyForAliaa)
              .toList();
          if (orders.isEmpty) return const EmptyWorkflow('No packed orders are waiting for a client number.');
          return ListView(
            padding: const EdgeInsets.all(16),
            children: orders
                .map(
                  (order) => WorkflowOrderCard(
                    order: order,
                    action: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _addClientNumber(context, order),
                        icon: const Icon(Icons.add_call),
                        label: const Text('Add client number'),
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

  void _addClientNumber(BuildContext context, WorkflowOrder order) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Client number — ${order.clientName}'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9+]'))],
            decoration: const InputDecoration(labelText: 'Client phone number', border: OutlineInputBorder()),
            validator: (value) => value == null || value.trim().length < 7 ? 'Enter a valid number' : null,
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              if (!formKey.currentState!.validate()) return;
              WorkflowStore.instance.complete(order.id, controller.text.trim());
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Client number added. Order completed.')),
              );
            },
            child: const Text('Save and complete'),
          ),
        ],
      ),
    ).whenComplete(controller.dispose);
  }
}
