class Cart {
  final int userId;
  final List<CartItem> items;

  Cart({required this.userId, required this.items});

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<CartItem> items = (json['products'] as List)
        .map((item) => CartItem.fromJson(item))
        .toList();
    return Cart(userId: json['userId'], items: items);
  }
}

class CartItem {
  final int productId;
  final int quantity;

  CartItem({required this.productId, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }
}
