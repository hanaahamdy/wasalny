import 'package:flutter/material.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/shared/models/employee_type.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../entity/employee_model.dart';
import '../../domain/repositories/employees_repository.dart';
import '../../view_models/employee_details_view_model.dart';
import '../../view_models/employees_view_model.dart';

part '../view/employees_screen.dart';
part '../view/employee_type_screen.dart';
part '../view/employee_details_screen.dart';
part '../view/edit_employee_profile_screen.dart';
part '../widgets/employee/employees_body.dart';
part '../widgets/employee/employee_card.dart';
part '../widgets/employee/employee_status_label.dart';
part '../widgets/employee_type_card.dart';
part '../widgets/employee_details/employee_profile_card.dart';
part '../widgets/employee_details/employee_details_body.dart';
part '../widgets/edit_employee_profile/edit_employee_profile_body.dart';
part '../widgets/edit_employee_profile/edit_employee_text_field.dart';
