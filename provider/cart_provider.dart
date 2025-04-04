import 'package:flutter/foundation.dart';
import 'package:pet_plus_new/model/cart_model.dart';
import 'package:pet_plus_new/model/shop_items.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  double get total => _items.fold(0, (sum, item) => sum + item.total);

  void addItem(ShopItem item) {
    final existingItem = _items.firstWhere(
      (cartItem) => cartItem.item.id == item.id,
      orElse: () => CartItem(item: item, quantity: 0),
    );

    if (existingItem.quantity == 0) {
      _items.add(CartItem(item: item));
    } else {
      existingItem.quantity++;
    }
    notifyListeners();
  }

  void removeItem(String itemId) {
    _items.removeWhere((item) => item.item.id == itemId);
    notifyListeners();
  }

  void updateQuantity(String itemId, int quantity) {
    if (quantity < 1) return;
    final item = _items.firstWhere((item) => item.item.id == itemId);
    item.quantity = quantity;
    notifyListeners();
  }
}
