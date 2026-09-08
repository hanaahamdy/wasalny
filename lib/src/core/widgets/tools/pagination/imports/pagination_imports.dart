import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/error/failure.dart';
import '../../../../extensions/base_state.dart';
import '../../../../shared/models/request_state.dart';
import '../../../custom_messages.dart';
import '../../../handling_views/error_view.dart';
import '../../../handling_views/not_contain_data.dart';
import '../../../universal_media/widgets.dart';

part '../cubits/paginated_cubit.dart';
part '../paginated_list_widget.dart';
part '../entity/paginated_data.dart';
part '../entity/pagination_meta.dart';
part '../paginated_list_config.dart';
