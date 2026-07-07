part of '../imports/stadiums_imports.dart';

class _ServicesGrid extends StatelessWidget {
  final List<StadiumService> services;

  const _ServicesGrid({required this.services});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 18.h,
        crossAxisSpacing: 22.w,
        childAspectRatio: 1.28,
      ),
      itemBuilder: (context, index) {
        final service = services[index];
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.035),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAFBF3),
                  borderRadius: BorderRadius.circular(11.r),
                ),
                child: Icon(
                  service.icon,
                  color: const Color(0xFF3DBB85),
                  size: 18.r,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                service.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 11.sp, color: AppColors.black),
              ),
            ],
          ),
        );
      },
    );
  }
}
