import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';

import '../../../../../../../../config/language/locale_keys.g.dart';
import '../../../../../../../../config/res/config_imports.dart';
import '../../../../../../../../core/navigation/navigator.dart';
import '../../../../../../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../../../../../../core/shared/models/user_model.dart';
import '../../../../../../home/presentation/imports/view_imports.dart';
import '../../entity/order_model.dart';
import '../../entity/order_tabs.dart';

part '../cubits/create_orders_cubit.dart';
part '../cubits/create_orders_state.dart';
part '../cubits/orders_cubit.dart';
part '../mixins/create_orders_mixin.dart';
part '../view/order_details_screen.dart';
part '../view/orders_screen.dart';
part '../widgets/order_card.dart';
part '../widgets/order_details_body.dart';
part '../widgets/order_details_row.dart';
part '../widgets/orders_body.dart';
part '../widgets/orders_tabs.dart';
