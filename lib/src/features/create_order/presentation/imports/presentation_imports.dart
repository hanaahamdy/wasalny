import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/extensions/base_state.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/custom_messages.dart';
import '../../../../core/widgets/fields/text_fields/custom_text_field.dart';
import '../../domain/repositories/create_order_repository.dart';
import '../../entity/create_order_params.dart';
import '../../entity/created_order_model.dart';

part '../views/create_orders_screen.dart';
part '../widgets/create_orders_body.dart';
part '../cubits/create_order/create_orders_cubit.dart';
part '../cubits/create_order/create_orders_state.dart';
part '../mixins/create_orders_mixin.dart';
