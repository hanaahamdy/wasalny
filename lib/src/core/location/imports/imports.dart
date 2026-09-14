import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart' show Position;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../config/language/locale_keys.g.dart';
import '../../../config/res/config_imports.dart';
import '../../extensions/widgets/sized_box_helper.dart';
import '../../extensions/text_style_extensions.dart';
import '../../helpers/location_helper.dart';
import '../../navigation/navigator.dart' show Go;
import '../../widgets/buttons/default_button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/scaffolds/default_scaffold.dart';
import '../widgets/map_widget.dart';

part '../cubit/location_cubit.dart';
part '../cubit/location_states.dart';
part '../screens/location_screen.dart';
