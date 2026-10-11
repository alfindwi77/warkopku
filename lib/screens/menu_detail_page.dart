import 'package:flutter/material.dart';

import '../models/cart_manager.dart';
import '../models/menu_addon.dart';
import 'menu_data.dart';

class MenuDetailPage extends StatefulWidget {
  final MenuItemData menu;

  const MenuDetailPage({super.key, required this.menu});

  @override
  State<MenuDetailPage> createState() => _MenuDetailPageState();
}

class _MenuDetailPageState extends State<MenuDetailPage> {
  int quantity = 1;

  final List<MenuAddon> selectedAddons = [];

  void changeQuantity(int value) {
    setState(() {
      quantity = (quantity + value).clamp(1, 99).toInt();
    });
  }

  void toggleAddon(MenuAddon addon) {
    setState(() {
      if (selectedAddons.contains(addon)) {
        selectedAddons.remove(addon);
      } else {
        selectedAddons.add(addon);
      }
    });
  }

  int get addonPrice {
    return selectedAddons.fold(0, (total, addon) => total + addon.priceValue);
  }

  int get pricePerItem {
    return widget.menu.priceValue + addonPrice;
  }

  int get total {
    return pricePerItem * quantity;
  }

  String formatRupiah(int value) {
    return 'Rp${value.toString().replaceAllMapped(RegExp(r'(?=(\d{3})+$)'), (_) => '.')}';
  }

  void addToCart() {
    CartManager.instance.addItem(
      widget.menu,
      quantity,
      List<MenuAddon>.from(selectedAddons),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${widget.menu.name} x$quantity ditambahkan ke keranjang',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail Menu')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              widget.menu.image,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.menu.name,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.menu.price,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF6F4E37),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.menu.description,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      color: Colors.black54,
                    ),
                  ),

                  if (widget.menu.addons.isNotEmpty) ...[
                    const SizedBox(height: 30),
                    const Text(
                      'Tambahan Menu',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Tambahan yang dipilih akan berlaku untuk setiap jumlah menu yang ditambahkan.',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: widget.menu.addons.map((addon) {
                          final selected = selectedAddons.contains(addon);

                          return CheckboxListTile(
                            value: selected,
                            onChanged: (_) {
                              toggleAddon(addon);
                            },
                            activeColor: const Color(0xFF6F4E37),
                            title: Text(
                              addon.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                              addon.priceValue == 0
                                  ? 'Gratis'
                                  : '+${addon.price}',
                              style: TextStyle(
                                color: addon.priceValue == 0
                                    ? Colors.green
                                    : const Color(0xFF6F4E37),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            secondary: const Icon(
                              Icons.add_circle_outline,
                              color: Color(0xFF6F4E37),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],

                  const SizedBox(height: 30),

                  const Text(
                    'Jumlah',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          changeQuantity(-1);
                        },
                        icon: const Icon(Icons.remove),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFFF0E6DC),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                        child: Center(
                          child: Text(
                            '$quantity',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          changeQuantity(1);
                        },
                        icon: const Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor: const Color(0xFF6F4E37),
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Harga menu',
                              style: TextStyle(color: Colors.black54),
                            ),
                            Text(
                              formatRupiah(widget.menu.priceValue * quantity),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        if (selectedAddons.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Tambahan',
                                style: TextStyle(color: Colors.black54),
                              ),
                              Text(
                                '+${formatRupiah(addonPrice * quantity)}',
                                style: const TextStyle(
                                  color: Color(0xFF6F4E37),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],

                        const Divider(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              formatRupiah(total),
                              style: const TextStyle(
                                fontSize: 20,
                                color: Color(0xFF6F4E37),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton.icon(
                      onPressed: addToCart,
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text(
                        'Tambah ke Pesanan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6F4E37),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
