import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/extensions/context_extension.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/widgets/buttons/default_button.dart';
import '../../../../auth/presentation/imports/view_imports.dart';
import '../../data/models/intro_slide_model.dart';
import '../../data/repositories/intro_repository.dart';

part '../view/intro_screen.dart';
part '../view_models/intro_view_model.dart';
part '../widgets/intro_body.dart';
part '../widgets/intro_indicator.dart';
part '../widgets/intro_logo.dart';
part '../widgets/intro_start_button.dart';
