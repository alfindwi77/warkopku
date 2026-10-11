import '../models/menu_addon.dart';

class MenuItemData {
  final String name;
  final String price;
  final int priceValue;
  final String category;
  final String image;
  final String description;
  final List<MenuAddon> addons;

  const MenuItemData({
    required this.name,
    required this.price,
    required this.priceValue,
    required this.category,
    required this.image,
    required this.description,
    this.addons = const [],
  });
}

const List<MenuItemData> menuItems = [
  MenuItemData(
    name: 'Kopi Hitam',
    price: 'Rp8.000',
    priceValue: 8000,
    category: 'Kopi',
    image: 'assets/images/menu/kopi_hitam.jpg',
    description: 'Kopi hitam dengan cita rasa kuat dan aroma khas kopi.',
    addons: [
      MenuAddon(name: 'Extra Shot', priceValue: 4000),
      MenuAddon(name: 'Less Sugar', priceValue: 0),
      MenuAddon(name: 'No Sugar', priceValue: 0),
    ],
  ),

  MenuItemData(
    name: 'Kopi Susu',
    price: 'Rp12.000',
    priceValue: 12000,
    category: 'Kopi',
    image: 'assets/images/menu/kopi_susu.jpg',
    description: 'Perpaduan kopi dan susu dengan rasa creamy dan lembut.',
    addons: [
      MenuAddon(name: 'Extra Shot', priceValue: 4000),
      MenuAddon(name: 'Extra Susu', priceValue: 3000),
      MenuAddon(name: 'Less Sugar', priceValue: 0),
      MenuAddon(name: 'No Sugar', priceValue: 0),
    ],
  ),

  MenuItemData(
    name: 'Es Teh Manis',
    price: 'Rp6.000',
    priceValue: 6000,
    category: 'Non-Kopi',
    image: 'assets/images/menu/es_teh_manis.jpg',
    description: 'Es teh manis segar yang cocok untuk menemani waktu santai.',
    addons: [
      MenuAddon(name: 'Less Sugar', priceValue: 0),
      MenuAddon(name: 'No Sugar', priceValue: 0),
      MenuAddon(name: 'Less Ice', priceValue: 0),
    ],
  ),

  MenuItemData(
    name: 'Es Jeruk',
    price: 'Rp8.000',
    priceValue: 8000,
    category: 'Non-Kopi',
    image: 'assets/images/menu/es_jeruk.jpg',
    description: 'Minuman jeruk segar dengan rasa manis dan sedikit asam.',
    addons: [
      MenuAddon(name: 'Extra Jeruk', priceValue: 3000),
      MenuAddon(name: 'Less Sugar', priceValue: 0),
      MenuAddon(name: 'No Sugar', priceValue: 0),
    ],
  ),

  MenuItemData(
    name: 'Indomie Goreng',
    price: 'Rp10.000',
    priceValue: 10000,
    category: 'Makanan',
    image: 'assets/images/menu/indomie_goreng.jpg',
    description:
        'Indomie goreng dengan bumbu gurih yang cocok untuk teman nongkrong.',
    addons: [
      MenuAddon(name: 'Telur', priceValue: 5000),
      MenuAddon(name: 'Sosis', priceValue: 4000),
      MenuAddon(name: 'Keju', priceValue: 3000),
      MenuAddon(name: 'Nugget', priceValue: 5000),
      MenuAddon(name: 'Baso', priceValue: 5000),
    ],
  ),

  MenuItemData(
    name: 'Indomie Rebus',
    price: 'Rp10.000',
    priceValue: 10000,
    category: 'Makanan',
    image: 'assets/images/menu/indomie_rebus.jpg',
    description: 'Indomie rebus hangat dengan kuah gurih untuk menemani malam.',
    addons: [
      MenuAddon(name: 'Telur', priceValue: 5000),
      MenuAddon(name: 'Sosis', priceValue: 4000),
      MenuAddon(name: 'Keju', priceValue: 3000),
      MenuAddon(name: 'Nugget', priceValue: 5000),
      MenuAddon(name: 'Baso', priceValue: 5000),
    ],
  ),

  MenuItemData(
    name: 'Nasi Goreng',
    price: 'Rp15.000',
    priceValue: 15000,
    category: 'Makanan',
    image: 'assets/images/menu/nasi_goreng.jpg',
    description: 'Nasi goreng dengan bumbu khas yang gurih dan nikmat.',
    addons: [
      MenuAddon(name: 'Extra Telur', priceValue: 5000),
      MenuAddon(name: 'Sosis', priceValue: 4000),
      MenuAddon(name: 'Extra Ayam', priceValue: 6000),
      MenuAddon(name: 'Nugget', priceValue: 5000),
      MenuAddon(name: 'Baso', priceValue: 5000),
    ],
  ),

  MenuItemData(
    name: 'Roti Bakar',
    price: 'Rp12.000',
    priceValue: 12000,
    category: 'Snack',
    image: 'assets/images/menu/roti_bakar.jpg',
    description:
        'Roti bakar hangat dengan tekstur renyah di luar dan lembut di dalam.',
    addons: [
      MenuAddon(name: 'Extra Cokelat', priceValue: 3000),
      MenuAddon(name: 'Keju', priceValue: 3000),
      MenuAddon(name: 'Susu', priceValue: 2000),
    ],
  ),

  MenuItemData(
    name: 'Pisang Goreng',
    price: 'Rp10.000',
    priceValue: 10000,
    category: 'Snack',
    image: 'assets/images/menu/pisang_goreng.jpg',
    description: 'Pisang goreng hangat dengan rasa manis dan tekstur renyah.',
    addons: [
      MenuAddon(name: 'Cokelat', priceValue: 3000),
      MenuAddon(name: 'Keju', priceValue: 3000),
      MenuAddon(name: 'Susu', priceValue: 2000),
    ],
  ),

  MenuItemData(
    name: 'Kentang Goreng',
    price: 'Rp12.000',
    priceValue: 12000,
    category: 'Snack',
    image: 'assets/images/menu/kentang_goreng.jpg',
    description: 'Kentang goreng renyah yang cocok untuk teman nongkrong.',
    addons: [
      MenuAddon(name: 'Extra Saus Keju', priceValue: 3000),
      MenuAddon(name: 'Extra Saus Sambal', priceValue: 2000),
      MenuAddon(name: 'Extra Saus Tomat', priceValue: 2000),
    ],
  ),

  MenuItemData(
    name: 'Cireng',
    price: 'Rp10.000',
    priceValue: 10000,
    category: 'Snack',
    image: 'assets/images/menu/cireng.jpg',
    description: 'Cireng gurih dengan tekstur kenyal dan renyah.',
    addons: [
      MenuAddon(name: 'Bumbu Rujak', priceValue: 2000),
      MenuAddon(name: 'Saus Keju', priceValue: 3000),
      MenuAddon(name: 'Bumbu Kacang', priceValue: 3000),
    ],
  ),
];
