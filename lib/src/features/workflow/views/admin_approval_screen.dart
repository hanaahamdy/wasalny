import 'package:flutter/material.dart';
import '../../../config/res/config_imports.dart';
import '../../users_type/admin/view_models/admin_approval_view_model.dart';
import '../models/workflow_order.dart';
import '../../../config/language/locale_keys.g.dart';
import 'widgets/workflow_widgets.dart';

class AdminApprovalScreen extends StatefulWidget {
  const AdminApprovalScreen({super.key});

  @override
  State<AdminApprovalScreen> createState() => _AdminApprovalScreenState();
}

class _AdminApprovalScreenState extends State<AdminApprovalScreen> {
  final _viewModel = AdminApprovalViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WorkflowPage(
      title: LocaleKeys.workflowBuyerApprovals,
      child: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final orders = _viewModel.orders;
          final liveRequests = _viewModel.liveRequests;
          if (orders.isEmpty && liveRequests.isEmpty) {
            return EmptyWorkflow(LocaleKeys.workflowNoRequests);
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (orders.isNotEmpty) ...[
                _SectionTitle(
                  icon: Icons.shopping_bag_outlined,
                  title: LocaleKeys.workflowCategoryOrders,
                  count: orders.length,
                ),
                const SizedBox(height: 10),
                ...orders.map(
                  (order) => WorkflowOrderCard(
                    order: order,
                    action: SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () {
                          _viewModel.approveOrder(order.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(LocaleKeys.workflowOrderApproved),
                            ),
                          );
                        },
                        icon: const Icon(Icons.check_circle_outline),
                        label: Text(LocaleKeys.workflowApproveOrder),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (liveRequests.isNotEmpty) ...[
                _SectionTitle(
                  icon: Icons.live_tv_outlined,
                  title: LocaleKeys.workflowLiveRequests,
                  count: liveRequests.length,
                ),
                const SizedBox(height: 10),
                ...liveRequests.map(
                  (request) => _LiveApprovalCard(
                    request: request,
                    onApprove: () => _viewModel.approveLive(request.id),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  final int count;
  const _SectionTitle({
    required this.icon,
    required this.title,
    required this.count,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: AppColors.scenarioPrimary),
      const SizedBox(width: 8),
      Expanded(
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Badge(label: Text('$count'), backgroundColor: AppColors.scenarioPrimary),
    ],
  );
}

class _LiveApprovalCard extends StatelessWidget {
  final WorkflowLiveRequest request;
  final VoidCallback onApprove;
  const _LiveApprovalCard({required this.request, required this.onApprove});

  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.only(bottom: 12),
    color: AppColors.white,
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.moreProfileIconBackground,
                child: Icon(
                  Icons.live_tv_outlined,
                  color: AppColors.scenarioPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  request.clientName,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(request.details),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () {
                onApprove();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(LocaleKeys.workflowLiveApproved)),
                );
              },
              icon: const Icon(Icons.check_circle_outline),
              label: Text(LocaleKeys.workflowApproveLive),
            ),
          ),
        ],
      ),
    ),
  );
}
