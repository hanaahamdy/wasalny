import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/dialogs/success_dialog.dart';
import '../../../../core/network/network_service.dart';
import '../../../../config/res/config_imports.dart';
import '../../../settings/more/presentation/more_screen.dart';
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
  late final AliaaViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = AliaaViewModel(injector<NetworkService>());
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
      title: LocaleKeys.workflowAliaa,
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
                        EmptyWorkflow(LocaleKeys.workflowNoClientNumbers),
                      ],
                    ),
                  );
                }
                return RefreshIndicator(
                  onRefresh: _viewModel.loadOrders,
                  child: ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.pW16,
                      vertical: AppPadding.pH16,
                    ),
                    children: [
                      WorkflowQueueHeader(
                        icon: Icons.contact_phone_outlined,
                        title: LocaleKeys.workflowAliaa,
                        subtitle: LocaleKeys.workflowAliaaQueue(
                          count: orders.length.toString(),
                        ),
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

  void _addClientNumber(BuildContext context, WorkflowOrder order) {
    showDialog<void>(
      context: context,
      builder: (_) => _ClientNumberDialog(order: order, viewModel: _viewModel),
    );
  }

  void _logout() => MoreScreen.showLogoutDialog(context);
}
