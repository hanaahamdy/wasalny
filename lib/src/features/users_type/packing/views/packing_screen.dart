import 'package:flutter/material.dart';
import '../../../workflow/models/workflow_order.dart';
import '../../../workflow/views/widgets/workflow_widgets.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../view_models/packing_view_model.dart';
import 'widgets/packing_slip_dialog.dart';

class PackingScreen extends StatefulWidget {
  const PackingScreen({super.key});

  @override
  State<PackingScreen> createState() => _PackingScreenState();
}

class _PackingScreenState extends State<PackingScreen> {
  final _viewModel = PackingViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WorkflowPage(
      title: LocaleKeys.workflowPacking,
      child: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final orders = _viewModel.orders;
          if (orders.isEmpty) {
            return EmptyWorkflow(LocaleKeys.workflowNoPackingOrders);
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              WorkflowQueueHeader(
                icon: Icons.inventory_2_outlined,
                title: LocaleKeys.workflowPacking,
                subtitle: LocaleKeys.workflowPackingQueue(orders.length),
                count: orders.length,
              ),
              ...orders.map(
                  (order) => WorkflowOrderCard(
                    order: order,
                    action: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _showPackingSlip(context, order),
                            icon: const Icon(Icons.print_outlined),
                            label: Text(LocaleKeys.workflowPrint),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              _viewModel.sendToAliaa(order.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    LocaleKeys.workflowSentToAliaa,
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(Icons.forward_to_inbox_outlined),
                            label: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                LocaleKeys.workflowSendToAliaa,
                                maxLines: 1,
                                softWrap: false,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _showPackingSlip(BuildContext context, WorkflowOrder order) {
    showDialog<void>(
      context: context,
      builder: (_) => PackingSlipDialog(order: order),
    );
  }
}
