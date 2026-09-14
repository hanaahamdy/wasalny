class CreateOrderProductParams {
  final String productName;
  final String quantity;
  final String price;

  const CreateOrderProductParams({
    required this.productName,
    required this.quantity,
    required this.price,
  });
}

class CreateOrderParams {
  final String name;
  final String phone;
  final String totalAmount;
  final String deliveryFee;
  final String partnerPrice;
  final String seller;
  final List<CreateOrderProductParams> products;

  const CreateOrderParams({
    required this.name,
    required this.phone,
    required this.totalAmount,
    required this.deliveryFee,
    required this.partnerPrice,
    required this.seller,
    required this.products,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{
      'name': name,
      'phone': phone,
      'total_amount': totalAmount,
      'delivery_fee': deliveryFee,
      'partner_price': partnerPrice,
      'seller': seller,
    };
    for (var index = 0; index < products.length; index++) {
      final product = products[index];
      json['products[$index][product_name]'] = product.productName;
      json['products[$index][quantity]'] = product.quantity;
      json['products[$index][price]'] = product.price;
    }
    return json;
  }
}
