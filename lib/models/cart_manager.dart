import 'package:flutter/foundation.dart';

import '../screens/menu_data.dart';
import 'cart_item.dart';
import 'menu_addon.dart';

class CartManager extends ChangeNotifier {
  CartManager._();

  static final CartManager instance = CartManager._();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get totalItems {
    return _items.fold(0, (total, item) => total + item.quantity);
  }

  int get totalPrice {
    return _items.fold(0, (total, item) => total + item.total);
  }

  void addItem(
    MenuItemData menu,
    int quantity, [
    List<MenuAddon> selectedAddons = const [],
  ]) {
    final sortedNewAddons = [...selectedAddons]
      ..sort((a, b) => a.name.compareTo(b.name));

    final index = _items.indexWhere((item) {
      if (item.menu.name != menu.name) {
        return false;
      }

      final existingAddons = [...item.selectedAddons]
        ..sort((a, b) => a.name.compareTo(b.name));

      if (existingAddons.length != sortedNewAddons.length) {
        return false;
      }

      for (int i = 0; i < existingAddons.length; i++) {
        if (existingAddons[i].name != sortedNewAddons[i].name) {
          return false;
        }
      }

      return true;
    });

    if (index != -1) {
      _items[index].quantity += quantity;
    } else {
      _items.add(
        CartItem(
          menu: menu,
          quantity: quantity,
          selectedAddons: List.unmodifiable(selectedAddons),
        ),
      );
    }

    notifyListeners();
  }

  void updateQuantity(CartItem item, int quantity) {
    final index = _items.indexOf(item);

    if (index == -1) return;

    if (quantity <= 0) {
      _items.removeAt(index);
    } else {
      _items[index].quantity = quantity;
    }

    notifyListeners();
  }

  void removeItem(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
