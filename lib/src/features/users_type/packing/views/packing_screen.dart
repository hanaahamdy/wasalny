import 'package:flutter/material.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/dialogs/success_dialog.dart';
import '../../../../core/network/network_service.dart';
import '../../../../config/res/config_imports.dart';
import '../../../settings/more/presentation/more_screen.dart';
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
  late final PackingViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = PackingViewModel(injector<NetworkService>());
    _viewModel.loadOrders();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WorkflowPage(
      title: LocaleKeys.workflowPacking,
      automaticallyImplyLeading: false,
      child: Column(
        children: [
          Expanded(
            child: ListenableBuilder(
              listenable: _viewModel,
              builder: (context, _) {
                final orders = _viewModel.orders;
                if (_viewModel.isLoading && orders.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (_viewModel.errorMessage != null && orders.isEmpty) {
                  return Center(
                    child: FilledButton(
                      onPressed: _viewModel.loadOrders,
                      child: Text(LocaleKeys.retry),
                    ),
                  );
                }
                if (orders.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: _viewModel.loadOrders,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * .3,
                        ),
                        EmptyWorkflow(LocaleKeys.workflowNoPackingOrders),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: _viewModel.loadOrders,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(16),
                    children: [
                      WorkflowQueueHeader(
                        icon: Icons.inventory_2_outlined,
                        title: LocaleKeys.workflowPacking,
                        subtitle: LocaleKeys.workflowPackingQueue(
                          count: orders.length.toString(),
                        ),
                        count: orders.length,
                      ),
                      ...orders.map(
                        (order) => WorkflowOrderCard(
                          order: order,
                          action: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton.icon(
                                  onPressed: () =>
                                      _showPackingSlip(context, order),
                                  icon: const Icon(Icons.print_outlined),
                                  label: Text(LocaleKeys.workflowPrint),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: FilledButton.icon(
                                  onPressed: _viewModel.isSending(order.id)
                                      ? null
                                      : () => _sendToAliaa(order.id),
                                  icon: _viewModel.isSending(order.id)
                                      ? const SizedBox.square(
                                          dimension: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.forward_to_inbox_outlined,
                                        ),
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
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              AppPadding.pW16,
              AppPadding.pH8,
              AppPadding.pW16,
              AppPadding.pH20,
            ),
            child: DefaultButton(title: LocaleKeys.logout, onTap: _logout),
          ),
        ],
      ),
    );
  }

  void _showPackingSlip(BuildContext context, WorkflowOrder order) {
    showDialog<void>(
      context: context,
      builder: (_) => PackingSlipDialog(order: order),
    );
  }

  Future<void> _sendToAliaa(int orderId) async {
    final sent = await _viewModel.sendToAliaa(orderId);
    if (!mounted) return;
    if (sent) {
      await successDialog(
        context: context,
        title: LocaleKeys.workflowSentToAliaa,
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_viewModel.errorMessage ?? LocaleKeys.exceptionError),
      ),
    );
  }

  void _logout() => MoreScreen.showLogoutDialog(context);
}
