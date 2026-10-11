import '../screens/menu_data.dart';
import 'menu_addon.dart';

class CartItem {
  final MenuItemData menu;
  final List<MenuAddon> selectedAddons;
  int quantity;

  CartItem({
    required this.menu,
    required this.quantity,
    this.selectedAddons = const [],
  });

  int get addonTotal {
    return selectedAddons.fold(0, (total, addon) => total + addon.priceValue);
  }

  int get pricePerItem {
    return menu.priceValue + addonTotal;
  }

  int get total {
    return pricePerItem * quantity;
  }

  String get addonDescription {
    if (selectedAddons.isEmpty) {
      return '';
    }

    return selectedAddons.map((addon) => addon.name).join(', ');
  }
}
