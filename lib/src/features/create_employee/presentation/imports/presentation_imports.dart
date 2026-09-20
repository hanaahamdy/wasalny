import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/widgets/seperator_helper.dart';
import '../../../../core/extensions/base_state.dart';
import '../../../../core/extensions/text_style_extensions.dart';
import '../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/custom_messages.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/dialogs/success_dialog.dart';
import '../../../../core/widgets/fields/text_fields/custom_text_field.dart';
import '../cubits/create_employee_state.dart';
import '../../domain/repositories/create_employee_repository.dart';
import '../../entity/create_employee_params.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/shared/models/employee_type.dart';

part '../view/create_employee_screen.dart';
part '../widgets/create_employee_body.dart';
part '../cubits/create_employee_cubit.dart';
part '../mixin/create_employee_controllers.dart';
