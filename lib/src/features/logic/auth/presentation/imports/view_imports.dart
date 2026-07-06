import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/extensions/base_state.dart';
import '../../../../../core/extensions/text_style_extensions.dart';
import '../../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../../core/helpers/validators.dart';
import '../../../../../core/widgets/custom_messages.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/fields/text_fields/custom_text_field.dart';
import '../../entity/login_params.dart';

part '../cubits/login_cubit.dart';
part '../cubits/login_state.dart';
part '../view/login_screen.dart';
part '../widgets/login/login_body.dart';
part '../widgets/login/login_header.dart';
