import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/widgets/seperator_helper.dart';
import '../../../../core/extensions/base_state.dart';
import '../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../core/helpers/location_helper.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/location/widgets/location_form_field.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/custom_messages.dart';
import '../../../../core/widgets/fields/text_fields/custom_text_field.dart';
import '../cubits/create_delivery_states.dart';
import '../../domain/repositories/create_delivery_repository.dart';
import '../../entity/create_delivery_params.dart';
import '../../../../core/navigation/navigator.dart';

part '../view/create_delivery_screen.dart';
part '../widgets/create_delivery_body.dart';
part '../cubits/create_delivery_cubit.dart';
part '../mixin/create_delivery_controllers.dart';
