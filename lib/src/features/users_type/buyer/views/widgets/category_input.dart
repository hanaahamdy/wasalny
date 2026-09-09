part of '../buyer_screen.dart';

class _CategoryInput {
  final name = TextEditingController();
  final count = TextEditingController(text: '1');
  final price = TextEditingController();
  double get total =>
      (int.tryParse(count.text) ?? 0) * (double.tryParse(price.text) ?? 0);
  void dispose() {
    name.dispose();
    count.dispose();
    price.dispose();
  }
}
