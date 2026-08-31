part of '../../imports/presentation_imports.dart';

class DeliveryImageUpload extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  const DeliveryImageUpload({
    super.key,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.deliveryProfilePhotoOptional,
          style: TextStyle(
            color: AppColors.main,
            fontSize: FontSizeManager.s11,
            fontWeight: FontWeightManager.regular,
          ),
        ),
        SizedBox(height: AppSize.sH6),
        CustomPaint(
          painter: _DashedBorderPainter(
            color: AppColors.inputBorder,
            radius: AppCircular.r12,
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppCircular.r12),
            child: SizedBox(
              width: double.infinity,
              height: AppSize.sH78,
              child: image == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt_outlined,
                          color: AppColors.secondaryHintText,
                          size: AppSize.sH20,
                        ),
                        SizedBox(height: AppSize.sH4),
                        Text(
                          LocaleKeys.uploadPhoto,
                          style: TextStyle(
                            color: AppColors.secondaryHintText,
                            fontSize: FontSizeManager.s10,
                          ),
                        ),
                      ],
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(AppCircular.r12),
                      child: Image.file(image!, fit: BoxFit.cover),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;

  const _DashedBorderPainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        canvas.drawPath(metric.extractPath(distance, distance + 5), paint);
        distance += 9;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.radius != radius;
  }
}
