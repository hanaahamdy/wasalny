part of '../imports/view_imports.dart';

class StaticPagesBody extends StatelessWidget {
  final StaticPageTypeEnum pageType;

  const StaticPagesBody({super.key, required this.pageType});

  Future<void> _onRefresh(BuildContext context) async {
    await context.read<StaticPagesCubit>().fetchStaticPage(pageType);
  }

  @override
  Widget build(BuildContext context) {
    return AsyncBlocBuilder<StaticPagesCubit, String?>(
      skeletonBuilder: (context) {
        return _StaticPageCard(
          child: const Text(
            '${SkeltonizerManager.veryLong} \n\n'
            '${SkeltonizerManager.veryLong} \n\n'
            '${SkeltonizerManager.veryLong}',
          ),
        );
      },
      builder: (context, data) {
        return RefreshIndicator(
          onRefresh: () => _onRefresh(context),
          child: _StaticPageCard(child: CustomHtmlWidget(data: data ?? '')),
        );
      },
    );
  }
}

class _StaticPageCard extends StatelessWidget {
  final Widget child;

  const _StaticPageCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 32.h),
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 677.h),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(40.w, 28.h, 40.w, 28.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(24.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.black.withValues(alpha: .03),
                blurRadius: 24,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
