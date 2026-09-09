import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/fields/text_fields/custom_text_field.dart';
import '../../../workflow/models/workflow_order.dart';
import '../../../workflow/views/widgets/workflow_widgets.dart';
import '../../../../config/language/locale_keys.g.dart';
import '../view_models/buyer_view_model.dart';
import 'widgets/buyer_action_card.dart';

part 'widgets/buyer_order_details.dart';
part 'widgets/buyer_live_request.dart';
part 'widgets/category_input.dart';
part 'widgets/category_editor.dart';

class BuyerScreen extends StatelessWidget {
  const BuyerScreen({super.key});

  @override
  Widget build(BuildContext context) => WorkflowPage(
    title: LocaleKeys.workflowBuyer,
    child: ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        Text(
          LocaleKeys.workflowChooseAction,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: AppColors.main,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(LocaleKeys.workflowSeparateRequests),
        const SizedBox(height: 24),
        BuyerActionCard(
          title: LocaleKeys.workflowCategoryOrder,
          subtitle: LocaleKeys.workflowCategoryOrderSubtitle,
          icon: Icons.shopping_bag_outlined,
          onTap: () => Go.to(const BuyerOrderDetailsScreen()),
        ),
        const SizedBox(height: 16),
        BuyerActionCard(
          title: LocaleKeys.workflowLive,
          subtitle: LocaleKeys.workflowLiveSubtitle,
          icon: Icons.live_tv_outlined,
          onTap: () => Go.to(const BuyerLiveRequestScreen()),
        ),
      ],
    ),
  );
}
