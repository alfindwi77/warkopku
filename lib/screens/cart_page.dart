import 'package:flutter/material.dart';

import '../models/cart_item.dart';
import '../models/cart_manager.dart';
import 'checkout_page.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  String formatRupiah(int value) {
    return 'Rp${value.toString().replaceAllMapped(RegExp(r'(?=(\d{3})+$)'), (_) => '.')}';
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartManager.instance;

    return AnimatedBuilder(
      animation: cart,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: const Text('Keranjang')),
          body: cart.items.isEmpty
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 80,
                        color: Colors.black26,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Keranjang masih kosong',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Silakan pilih menu terlebih dahulu.',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: cart.items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final item = cart.items[index];

                          return _CartItemCard(
                            item: item,
                            formatRupiah: formatRupiah,
                            onIncrease: () {
                              cart.updateQuantity(item, item.quantity + 1);
                            },
                            onDecrease: () {
                              cart.updateQuantity(item, item.quantity - 1);
                            },
                            onRemove: () {
                              cart.removeItem(item);
                            },
                          );
                        },
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Total',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                formatRupiah(cart.totalPrice),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF6F4E37),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 14),

                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const CheckoutPage(),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6F4E37),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                              child: const Text(
                                'Lanjut ke Checkout',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}

class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final String Function(int) formatRupiah;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.formatRupiah,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item.menu.image,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.menu.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  formatRupiah(item.menu.priceValue),
                  style: const TextStyle(
                    color: Color(0xFF6F4E37),
                    fontWeight: FontWeight.w600,
                  ),
                ),

                if (item.selectedAddons.isNotEmpty) ...[
                  const SizedBox(height: 7),

                  const Text(
                    'Tambahan:',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),

                  const SizedBox(height: 3),

                  ...item.selectedAddons.map(
                    (addon) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(
                        '• ${addon.name} '
                        '(+${formatRupiah(addon.priceValue)})',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                Row(
                  children: [
                    _QuantityButton(icon: Icons.remove, onPressed: onDecrease),

                    SizedBox(
                      width: 40,
                      child: Center(
                        child: Text(
                          '${item.quantity}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    _QuantityButton(icon: Icons.add, onPressed: onIncrease),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),

              const SizedBox(height: 8),

              Text(
                formatRupiah(item.total),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6F4E37),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _QuantityButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      height: 32,
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        icon: Icon(icon, size: 17),
        style: IconButton.styleFrom(backgroundColor: const Color(0xFFF0E6DC)),
      ),
    );
  }
}
