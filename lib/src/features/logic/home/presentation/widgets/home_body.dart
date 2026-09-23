part of '../imports/view_imports.dart';

class _HomeBody extends StatelessWidget {
  final int index;

  const _HomeBody(this.index);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const _HomeDashboard();
      case 1:
        return const OrdersScreen();
      case 2:
        return const MoreScreen();
      default:
        return const SizedBox.shrink();
    }
  }
}
