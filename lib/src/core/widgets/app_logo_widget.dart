import 'package:flutter/material.dart';

import '../../config/res/assets.gen.dart';

class AppLogoWidget extends StatelessWidget {
  final double size;

  const AppLogoWidget({super.key, this.size = 118});

  @override
  Widget build(BuildContext context) {
    return AppAssets.svg.appSvg.appLogoPng.image(
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
