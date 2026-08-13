import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/base_crud/code/domain/base_domain_imports.dart';
import '../../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../../core/extensions/base_state.dart';
import '../../../../../core/navigation/navigator.dart';
import '../../../../../core/network/api_endpoints.dart';
import '../../../../../core/shared/models/base_model.dart';
import '../../../../../core/widgets/buttons/loading_button.dart';
import '../../../../../core/widgets/custom_appbar.dart';
import '../../../../../core/widgets/custom_messages.dart';

part 'cubits/charge_wallet_cubit.dart';
part 'cubits/wallet_cubit.dart';
part '../../data/wallet/wallet_entity.dart';
part 'view/wallet_view.dart';
part 'widgets/wallet_balance_card.dart';
part 'widgets/wallet_recharge_button.dart';
part 'widgets/charge_wallet_dialog.dart';
