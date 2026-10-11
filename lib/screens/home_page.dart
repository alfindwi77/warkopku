import 'package:flutter/material.dart';
import '../widgets/category_chip.dart';
import '../widgets/menu_card.dart';
import '../models/cart_manager.dart';
import 'cart_page.dart';
import 'menu_detail_page.dart';
import 'menu_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'Semua';

  final List<String> categories = [
    'Semua',
    'Kopi',
    'Non-Kopi',
    'Makanan',
    'Snack',
  ];

  List<MenuItemData> get filteredMenus {
    if (selectedCategory == 'Semua') {
      return menuItems;
    }

    return menuItems
        .where((menu) => menu.category == selectedCategory)
        .toList();
  }

  void openCart() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CartPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartManager.instance;

    return AnimatedBuilder(
      animation: cart,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'WarkopKu',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: openCart,
                icon: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart_outlined, size: 27),
                    if (cart.totalItems > 0)
                      Positioned(
                        right: -7,
                        top: -7,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF6F4E37),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            cart.totalItems > 99 ? '99+' : '${cart.totalItems}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 24),
            children: [
              const Text(
                'Selamat Datang di',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 4),
              const Text(
                'WarkopKu ☕',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A4038),
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Pesan makanan dan minuman favoritmu dengan mudah.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),

              const SizedBox(height: 20),

              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/menu/kopi_hitam.jpg',
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.black.withValues(alpha: 0.65),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const Positioned(
                      left: 18,
                      top: 30,
                      right: 120,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ngopi Santai',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Nikmati menu favoritmu di WarkopKu.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Kategori',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              SizedBox(
                height: 45,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    CategoryChip(
                      label: 'Semua',
                      icon: Icons.restaurant_menu,
                      selected: selectedCategory == 'Semua',
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Semua';
                        });
                      },
                    ),
                    CategoryChip(
                      label: 'Kopi',
                      icon: Icons.coffee,
                      selected: selectedCategory == 'Kopi',
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Kopi';
                        });
                      },
                    ),
                    CategoryChip(
                      label: 'Non-Kopi',
                      icon: Icons.local_drink,
                      selected: selectedCategory == 'Non-Kopi',
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Non-Kopi';
                        });
                      },
                    ),
                    CategoryChip(
                      label: 'Makanan',
                      icon: Icons.ramen_dining,
                      selected: selectedCategory == 'Makanan',
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Makanan';
                        });
                      },
                    ),
                    CategoryChip(
                      label: 'Snack',
                      icon: Icons.fastfood,
                      selected: selectedCategory == 'Snack',
                      onTap: () {
                        setState(() {
                          selectedCategory = 'Snack';
                        });
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${filteredMenus.length} menu',
                    style: const TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ...filteredMenus.map(
                (menu) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: MenuCard(
                    menu: menu,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MenuDetailPage(menu: menu),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
