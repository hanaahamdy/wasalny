import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/extensions/base_state.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../../../core/shared/models/user_model.dart';
import '../../../../../core/widgets/custom_loading.dart';
import '../../../../../core/widgets/handling_views/error_view.dart';
import '../../../../../core/widgets/navigation_bar/navigation_bar.dart';
import '../../../home_tabs/admin/admin_home/presentation/imports/presentation_imports.dart';
import '../../../home_tabs/delivery/delivery_home/presentation/imports/presentation_imports.dart';
import '../../../home_tabs/shared/feature/orders/presentation/imports/view_imports.dart';
import '../../../home_tabs/shared/widgets/home _order_sumary_card.dart';
import '../../../../settings/more/presentation/more_screen.dart';
import '../../entity/home_params.dart';
import '../../models/home_model.dart';
import '../../view_models/home_cubit.dart';

part '../view/home_screen.dart';
part '../../../home_tabs/admin/admin_home/presentation/view/admin_home.dart';
part '../widgets/home_body.dart';
part '../widgets/home_dashboard.dart';
