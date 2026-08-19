import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/language/locale_keys.g.dart';
import '../../../../../../config/res/assets.gen.dart';
import '../../../../../../config/res/config_imports.dart';
import '../../../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../../../core/extensions/text_style_extensions.dart';
import '../../../../../../core/extensions/widgets/sized_box_helper.dart';
import '../../../../../../core/helpers/image_helper.dart';
import '../../../../../../core/helpers/validators.dart';
import '../../../../../../core/navigation/navigator.dart';
import '../../../../../../core/network/api_endpoints.dart';
import '../../../../../../core/shared/models/base_model.dart';
import '../../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../../core/widgets/custom_appbar.dart';
import '../../../../../../core/widgets/dialogs/success_dialog.dart';
import '../../../../../../core/widgets/fields/drop_downs/app_drop_down/app_dropdown.dart';
import '../../../../../../core/widgets/fields/text_fields/custom_text_field.dart';

part '../../../data/create_team/create_team_params.dart';
part '../cubits/create_team_cubit.dart';
part '../cubits/create_team_sports_cubit.dart';
part '../view/create_team_view.dart';
part '../widgets/create_team/create_team_card.dart';
part '../widgets/create_team/create_team_submit_button.dart';
part '../widgets/create_team/team_image_picker_field.dart';
