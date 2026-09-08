import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/extensions/base_state.dart';
import '../../../../../core/shared/models/request_state.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../core/widgets/custom_html_widget.dart';
import '../../../../../core/widgets/tools/bloc_builder/request_bloc_builder.dart';
import '../../entity/static_pages_enum.dart';
import '../../domain/repositories/static_pages_repository.dart';

part '../view/static_pages_screen.dart';
part '../widgets/static_pages_body.dart';
part '../cubits/static_pages_cubit.dart';
