part of '../imports/view_imports.dart';

class _HomeBody extends StatelessWidget {
  final int index;
  const _HomeBody(this.index);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const StadiumsHomeView();
      case 1:
        return const BookingsView();
      case 2:
        return const WalletView();
      case 3:
        return const MoreTabView();

      default:
        return const SizedBox.shrink();
    }
  }
}
