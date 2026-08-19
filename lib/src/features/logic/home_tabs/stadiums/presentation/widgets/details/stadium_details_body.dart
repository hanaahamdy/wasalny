part of '../../imports/stadiums_imports.dart';

class _StadiumDetailsBody extends StatelessWidget {
  final AsyncState<Stadium?> state;
  final VoidCallback onRetry;

  const _StadiumDetailsBody({required this.state, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return switch ((state.status, state.data)) {
      (BaseStatus.error, _) => _StadiumErrorView(
        message: state.errorMessage,
        onRetry: onRetry,
      ),
      (BaseStatus.success, final stadium?) => _StadiumDetailsContent(
        stadium: stadium,
      ),
      _ => const Center(child: LoadingIndicator(color: AppColors.primary)),
    };
  }
}
