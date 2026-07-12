import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

import '../../../../../config/language/locale_keys.g.dart';
import '../../../../../config/res/assets.gen.dart';
import '../../../../../config/res/config_imports.dart';
import '../../../../../core/base_crud/code/presentation/cubit/base_cubit/async_cubit.dart';
import '../../../../../core/widgets/universal_media/widgets.dart';

part 'cubits/wallet_cubit.dart';
part 'data/fake_wallet_api.dart';
part 'entity/wallet_entity.dart';
part 'view/wallet_view.dart';
part 'widgets/wallet_balance_card.dart';
part 'widgets/wallet_header.dart';
part 'widgets/wallet_recharge_button.dart';
part 'widgets/wallet_small_chip.dart';
