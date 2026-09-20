import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../config/language/locale_keys.g.dart';
import '../../../../../../../config/res/config_imports.dart';
import '../../../../../../../core/extensions/base_state.dart';
import '../../../../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../../../../core/shared/models/request_state.dart';
import '../../../../../../../core/widgets/custom_messages.dart';
import '../../../../admin/admin_home/presentation/imports/presentation_imports.dart';
import '../../../../shared/feature/orders/entity/order_model.dart';
import '../../../../shared/feature/orders/presentation/imports/view_imports.dart';
import '../../../../shared/widgets/home_order_summary_card.dart';
import '../../../../shared/widgets/view_all_orders_widget.dart';
import '../../entity/delivery_home_model.dart';
import '../cubits/delivery_home_cubit.dart';

part '../view/delivery_home_screen.dart';
part '../widgets/delivery_home_order_summary_cards.dart';
part '../widgets/deliveey_home_body.dart';
