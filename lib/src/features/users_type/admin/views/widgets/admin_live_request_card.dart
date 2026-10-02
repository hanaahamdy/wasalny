import 'package:flutter/material.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/config_imports.dart';
import '../../models/admin_live_request.dart';

class AdminLiveRequestCard extends StatelessWidget {
  final AdminLiveRequest request;
  final bool isProcessing;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const AdminLiveRequestCard({
    super.key,
    required this.request,
    required this.isProcessing,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: AppPadding.pH12),
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.all(AppPadding.pW16),
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
                SizedBox(width: AppSize.sW12),
                Expanded(
                  child: Text(
                    request.broadcastName.isEmpty
                        ? LocaleKeys.workflowLiveRequest
                        : request.broadcastName,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (request.id > 0) Text('#${request.id}'),
              ],
            ),
            SizedBox(height: AppSize.sH12),
            _informationRow(
              context,
              label: LocaleKeys.adminLiveBroadcastName,
              value: request.broadcastName,
              icon: Icons.live_tv_outlined,
            ),
            _informationRow(
              context,
              label: LocaleKeys.adminLiveDescription,
              value: request.description,
              icon: Icons.description_outlined,
            ),
            _informationRow(
              context,
              label: LocaleKeys.adminLiveSellerName,
              value: request.sellerName,
              icon: Icons.person_outline,
            ),
            _informationRow(
              context,
              label: LocaleKeys.adminLiveSellerEmail,
              value: request.sellerEmail,
              icon: Icons.email_outlined,
            ),
            if (request.isPending) ...[
              SizedBox(height: AppSize.sH12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      onPressed: isProcessing ? null : onAccept,
                      icon: const Icon(Icons.check_circle_outline),
                      label: Text(LocaleKeys.adminLiveAccept),
                    ),
                  ),
                  SizedBox(width: AppSize.sW10),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: isProcessing ? null : onReject,
                      icon: const Icon(Icons.cancel_outlined),
                      label: Text(LocaleKeys.adminLiveReject),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _informationRow(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppPadding.pH10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.scenarioPrimary, size: AppSize.sH18),
          SizedBox(width: AppSize.sW8),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: value.isEmpty
                        ? LocaleKeys.errorExceptionNotContain
                        : value,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
