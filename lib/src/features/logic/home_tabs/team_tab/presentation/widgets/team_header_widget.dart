part of '../imports/view_imports.dart';

class TeamHeaderWidget extends StatelessWidget {
  const TeamHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 205.h,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF111827), Color(0xFF0B5D45)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(child: CustomPaint(painter: _StadiumHeaderPainter())),
          PositionedDirectional(
            top: 45.h,
            end: AppPadding.pW18,
            child: Container(
              width: 30.w,
              height: 30.w,
              decoration: BoxDecoration(
                color: AppColors.black.withValues(alpha: .45),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.white,
                size: 14.sp,
              ),
            ),
          ),
          PositionedDirectional(
            start: AppPadding.pW18,
            bottom: 23.h,
            child: Container(
              width: 58.w,
              height: 58.w,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppCircular.r12),
                boxShadow: [AppColors.containerShadow],
              ),
              child: const Icon(
                Icons.sports_soccer_rounded,
                color: Color(0xFF36B882),
                size: 32,
              ),
            ),
          ),
          PositionedDirectional(
            end: AppPadding.pW18,
            bottom: 26.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  LocaleKeys.teamName,
                  style: const TextStyle().setWhiteColor.s20.bold,
                ),
                4.h.szH,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      LocaleKeys.teamPlayersCount,
                      style: const TextStyle().setWhiteColor.s12.medium,
                    ),
                    5.w.szW,
                    Icon(
                      Icons.person_rounded,
                      color: AppColors.white,
                      size: 13.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StadiumHeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lightPaint = Paint()
      ..color = AppColors.white.withValues(alpha: .13)
      ..strokeWidth = 1.2;
    final fieldPaint = Paint()..color = const Color(0xFF36B882);
    final glowPaint = Paint()
      ..color = const Color(0xFF43D9C5).withValues(alpha: .25)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke;

    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height * .5),
        width: size.width * 1.45,
        height: size.height * .55,
      ),
      glowPaint,
    );

    for (var i = 0; i < 8; i++) {
      final x = size.width * (i / 7);
      canvas.drawLine(
        Offset(x, 0),
        Offset(size.width / 2, size.height),
        lightPaint,
      );
    }

    final fieldPath = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * .66, size.height * .64)
      ..lineTo(size.width * .34, size.height * .64)
      ..close();
    canvas.drawPath(fieldPath, fieldPaint);

    final linePaint = Paint()
      ..color = AppColors.white.withValues(alpha: .5)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(size.width / 2, size.height * .64),
      Offset(size.width / 2, size.height),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
