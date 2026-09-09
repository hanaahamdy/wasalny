import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../workflow/models/workflow_order.dart';
import '../../../workflow/views/widgets/workflow_widgets.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../view_models/aliaa_view_model.dart';

part 'widgets/client_number_dialog.dart';

class AliaaScreen extends StatefulWidget {
  const AliaaScreen({super.key});

  @override
  State<AliaaScreen> createState() => _AliaaScreenState();
}

class _AliaaScreenState extends State<AliaaScreen> {
  final _viewModel = AliaaViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WorkflowPage(
      title: LocaleKeys.workflowAliaaNumbers,
      child: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final orders = _viewModel.orders;
          if (orders.isEmpty) {
            return EmptyWorkflow(LocaleKeys.workflowNoClientNumbers);
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              WorkflowQueueHeader(
                icon: Icons.contact_phone_outlined,
                title: LocaleKeys.workflowAliaa,
                subtitle: LocaleKeys.workflowAliaaQueue(orders.length),
                count: orders.length,
              ),
              ...orders.map(
                  (order) => WorkflowOrderCard(
                    order: order,
                    action: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _addClientNumber(context, order),
                        icon: const Icon(Icons.add_call),
                        label: Text(LocaleKeys.workflowAddClientNumber),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _addClientNumber(BuildContext context, WorkflowOrder order) {
    showDialog<void>(
      context: context,
      builder: (_) => _ClientNumberDialog(order: order, viewModel: _viewModel),
    );
  }
}
