part of '../imports/view_imports.dart';

class _HomeBody extends StatelessWidget {
  final int index;

  const _HomeBody(this.index);

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return UserCubit.instance.user.userType == UserType.admin
            ? const AdminHome()
            : const DeliveryHomeScreen();
      case 1:
        return const OrdersScreen();
      case 3:
        return const SizedBox.shrink();
      default:
        return const SizedBox.shrink();
    }
  }
}
