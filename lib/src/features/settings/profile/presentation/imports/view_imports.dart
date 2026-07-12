import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../../core/extensions/base_state.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../core/widgets/dialogs/success_dialog.dart';
import '../../../../../core/widgets/image_widgets/cached_image.dart';
import '../../../../../core/helpers/validators.dart';

part '../view/edit_profile_view.dart';
part '../view/profile_view.dart';
part '../cubits/profile_change_password_cubit.dart';
part '../widgets/dialogs/change_password_bottom_sheet.dart';
