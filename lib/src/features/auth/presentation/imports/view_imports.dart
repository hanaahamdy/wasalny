import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../config/language/locale_keys.g.dart';
import '../../../../config/res/assets.gen.dart';
import '../../../../config/res/config_imports.dart';
import '../../../../core/extensions/text_style_extensions.dart';
import '../../../../core/helpers/validators.dart';
import '../../../../core/navigation/navigator.dart';
import '../../../../core/widgets/buttons/default_button.dart';
import '../../../../core/widgets/fields/text_fields/custom_text_field.dart';
import '../../../workflow/presentation/role_selection_screen.dart';

part '../cubits/auth_form_state.dart';
part '../cubits/login_cubit.dart';
part '../cubits/register_cubit.dart';
part '../mixins/login_mixin.dart';
part '../mixins/register_mixin.dart';
part '../view/login_screen.dart';
part '../view/register_screen.dart';
part '../widgets/auth_action_link.dart';
part '../widgets/auth_brand.dart';
part '../widgets/auth_form_card.dart';
part '../widgets/auth_header.dart';
part '../widgets/auth_shell.dart';
