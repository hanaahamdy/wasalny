import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../../config/language/locale_keys.g.dart';
import '../../../../../../config/res/config_imports.dart';
import '../../../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../../../core/extensions/widgets/widget_extension.dart';
import '../../../../../../core/navigation/navigator.dart';
import '../../../../../../core/shared/cubits/user_cubit/user_cubit.dart';
import '../../../../../../core/widgets/buttons/default_button.dart';
import '../../../../../settings/notifications/presentation/imports/view_imports.dart';
import '../../../create_match/presentation/imports/create_match_imports.dart';
import '../../../create_team/presentation/imports/view_imports.dart';
import '../../../sports/presentation/sports_feature.dart';
import '../../../stadiums/presentation/imports/stadiums_imports.dart';
import '../widgets/main_tab_search.dart';

part '../view/main_tab_screen.dart';
part '../widgets/home_hero.dart';
part '../widgets/quick_actions.dart';
part '../widgets/main_tab_common_widgets.dart';
part '../widgets/section_header.dart';
part '../widgets/main_tab_shimmers.dart';
