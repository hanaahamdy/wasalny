import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../models/workflow_order.dart';
import '../../../../config/language/locale_keys.g.dart';

class WorkflowPage extends StatelessWidget {
  final String title;
  final Widget child;

  const WorkflowPage({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final baseTheme = Theme.of(context);
    return Theme(
      data: baseTheme.copyWith(
        colorScheme: baseTheme.colorScheme.copyWith(
          primary: AppColors.scenarioPrimary,
          secondary: AppColors.scenarioPrimary,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.scenarioPrimary,
          ),
        ),
      ),
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        child: Scaffold(
          appBar: CustomAppBar(title: title),
          body: SafeArea(
            top: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: child,
              ),
            ),
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
                    Expanded(
                      child: Text(
                        LocaleKeys.workflowItemCount(
                          name: item.name,
                          count: item.count.toString(),
                        ),
                      ),
                    ),
                    Text(
                      LocaleKeys.workflowAmountEgp(
                        amount: item.total.toStringAsFixed(2),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    LocaleKeys.workflowTotalPrice,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  LocaleKeys.workflowAmountEgp(
                    amount: order.totalPrice.toStringAsFixed(2),
                  ),
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
                  color: AppColors.moreProfileIconBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '${LocaleKeys.workflowLiveRequest}${order.facebookRequest.isEmpty ? '' : ': ${order.facebookRequest}'}',
                ),
              ),
            ],
            if (order.clientNumber != null) ...[
              const SizedBox(height: 10),
              Text(
                LocaleKeys.workflowClientNumberTitle(name: order.clientNumber!),
              ),
            ],
            if (action != null) ...[const SizedBox(height: 12), action!],
          ],
        ),
      ),
    );
  }
}

class WorkflowQueueHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final int count;

  const WorkflowQueueHeader({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.scenarioGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [AppColors.containerShadow],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: .16),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: AppColors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: AppColors.white.withValues(alpha: .84),
                  ),
                ),
              ],
            ),
          ),
          CircleAvatar(
            backgroundColor: AppColors.white,
            child: Text(
              '$count',
              style: TextStyle(
                color: AppColors.scenarioPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
            const Icon(
              Icons.inventory_2_outlined,
              size: 54,
              color: Colors.grey,
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
