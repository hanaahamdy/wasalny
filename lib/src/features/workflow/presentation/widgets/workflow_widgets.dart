import 'package:flutter/material.dart';
import '../../../../config/res/config_imports.dart';
import '../../domain/workflow_order.dart';

class WorkflowPage extends StatelessWidget {
  final String title;
  final Widget child;

  const WorkflowPage({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: child,
          ),
        ),
      ),
    );
  }
}

class WorkflowOrderCard extends StatelessWidget {
  final WorkflowOrder order;
  final Widget? action;

  const WorkflowOrderCard({super.key, required this.order, this.action});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    order.clientName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text('#${order.id.toString().substring(7)}'),
              ],
            ),
            const SizedBox(height: 10),
            ...order.categories.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    Expanded(child: Text('${item.name} × ${item.count}')),
                    Text('${item.total.toStringAsFixed(2)} EGP'),
                  ],
                ),
              ),
            ),
            const Divider(),
            Row(
              children: [
                const Expanded(
                  child: Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Text(
                  '${order.totalPrice.toStringAsFixed(2)} EGP',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            if (order.facebookLiveRequested) ...[
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Facebook Live request${order.facebookRequest.isEmpty ? '' : ': ${order.facebookRequest}'}',
                ),
              ),
            ],
            if (order.clientNumber != null) ...[
              const SizedBox(height: 10),
              Text('Client number: ${order.clientNumber}'),
            ],
            if (action != null) ...[const SizedBox(height: 12), action!],
          ],
        ),
      ),
    );
  }
}

class EmptyWorkflow extends StatelessWidget {
  final String message;
  const EmptyWorkflow(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.inventory_2_outlined, size: 54, color: Colors.grey),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
