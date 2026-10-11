import 'package:flutter/material.dart';

import '../models/cart_manager.dart';
import '../models/table_manager.dart';
import 'payment_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final CartManager cart = CartManager.instance;
  final TableManager tableManager = TableManager.instance;

  String orderType = 'Dine In';
  String paymentMethod = 'Cash / Tunai';

  String formatRupiah(int value) {
    return 'Rp${value.toString().replaceAllMapped(RegExp(r'(?=(\d{3})+$)'), (_) => '.')}';
  }

  @override
  Widget build(BuildContext context) {
    final tableNumber = tableManager.tableNumber ?? 'Belum dipilih';

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  'Jenis Pesanan',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _OrderTypeButton(
                        title: 'Dine In',
                        icon: Icons.restaurant,
                        selected: orderType == 'Dine In',
                        onTap: () {
                          setState(() {
                            orderType = 'Dine In';
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _OrderTypeButton(
                        title: 'Take Away',
                        icon: Icons.shopping_bag_outlined,
                        selected: orderType == 'Take Away',
                        onTap: () {
                          setState(() {
                            orderType = 'Take Away';
                          });
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                const Text(
                  'Meja',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.table_restaurant,
                        color: Color(0xFF6F4E37),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Nomor Meja',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      Text(
                        tableNumber,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6F4E37),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Ringkasan Pesanan',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      ...cart.items.map((item) {
                        final basePrice = item.menu.priceValue * item.quantity;

                        final addonTotal = item.selectedAddons.fold(
                          0,
                          (total, addon) =>
                              total + (addon.priceValue * item.quantity),
                        );

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${item.menu.name} '
                                      'x${item.quantity}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    formatRupiah(basePrice),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),

                              if (item.selectedAddons.isNotEmpty) ...[
                                const SizedBox(height: 7),

                                ...item.selectedAddons.map((addon) {
                                  final addonSubtotal =
                                      addon.priceValue * item.quantity;

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 8,
                                      top: 3,
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            '+ ${addon.name} '
                                            'x${item.quantity}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          '+${formatRupiah(addonSubtotal)}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),

                                const SizedBox(height: 7),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Subtotal item',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black45,
                                      ),
                                    ),
                                    Text(
                                      formatRupiah(basePrice + addonTotal),
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF6F4E37),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ],
                          ),
                        );
                      }),

                      const Divider(),

                      const SizedBox(height: 4),

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
                              fontSize: 19,
                              color: Color(0xFF6F4E37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'Metode Pembayaran',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                _PaymentOption(
                  title: 'Cash / Tunai',
                  subtitle: 'Bayar secara tunai',
                  icon: Icons.payments_outlined,
                  selected: paymentMethod == 'Cash / Tunai',
                  onTap: () {
                    setState(() {
                      paymentMethod = 'Cash / Tunai';
                    });
                  },
                ),

                const SizedBox(height: 10),

                _PaymentOption(
                  title: 'QRIS',
                  subtitle: 'Bayar menggunakan QRIS',
                  icon: Icons.qr_code_2,
                  selected: paymentMethod == 'QRIS',
                  onTap: () {
                    setState(() {
                      paymentMethod = 'QRIS';
                    });
                  },
                ),
              ],
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: cart.items.isEmpty
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PaymentPage(
                              orderType: orderType,
                              tableNumber: tableNumber,
                              paymentMethod: paymentMethod,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F4E37),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFFB8A99D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Text(
                  paymentMethod == 'QRIS'
                      ? 'Lanjut ke Pembayaran QRIS'
                      : 'Konfirmasi Pesanan',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderTypeButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _OrderTypeButton({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? const Color(0xFF6F4E37) : Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            children: [
              Icon(
                icon,
                color: selected ? Colors.white : const Color(0xFF6F4E37),
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.white : const Color(0xFF4A4038),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected
                  ? const Color(0xFF6F4E37)
                  : const Color(0xFFE5D8CA),
              width: selected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF6F4E37), size: 28),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                selected ? Icons.radio_button_checked : Icons.radio_button_off,
                color: selected ? const Color(0xFF6F4E37) : Colors.black26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
