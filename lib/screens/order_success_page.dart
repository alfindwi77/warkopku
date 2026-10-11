import 'package:flutter/material.dart';

import '../models/cart_manager.dart';
import 'home_page.dart';

class OrderSuccessPage extends StatefulWidget {
  final String orderType;
  final String tableNumber;
  final String paymentMethod;
  final int total;

  const OrderSuccessPage({
    super.key,
    required this.orderType,
    required this.tableNumber,
    required this.paymentMethod,
    required this.total,
  });

  @override
  State<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends State<OrderSuccessPage> {
  late final String orderNumber;

  @override
  void initState() {
    super.initState();

    orderNumber =
        'WK-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

    // Pesanan sudah berhasil, maka keranjang dikosongkan.
    CartManager.instance.clear();
  }

  String formatRupiah(int value) {
    return 'Rp${value.toString().replaceAllMapped(RegExp(r'(?=(\d{3})+$)'), (_) => '.')}';
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 30),

                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7F4E8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 52,
                      color: Colors.green,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Pesanan Berhasil!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    'Pesanan kamu sudah berhasil dibuat.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black54, fontSize: 15),
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Nomor Pesanan',
                          style: TextStyle(color: Colors.black54),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          orderNumber,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF6F4E37),
                          ),
                        ),

                        const Divider(height: 30),

                        _InfoRow(
                          label: 'Jenis Pesanan',
                          value: widget.orderType,
                        ),

                        const SizedBox(height: 14),

                        _InfoRow(label: 'Meja', value: widget.tableNumber),

                        const SizedBox(height: 14),

                        _InfoRow(
                          label: 'Pembayaran',
                          value: widget.paymentMethod,
                        ),

                        const Divider(height: 30),

                        _InfoRow(
                          label: 'Total',
                          value: formatRupiah(widget.total),
                          valueBold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF3E8),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, color: Color(0xFF6F4E37)),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Pesanan sedang diproses. '
                            'Silakan menunggu pesanan di meja yang telah dipilih.',
                            style: TextStyle(
                              color: Color(0xFF5D4037),
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const HomePage()),
                          (route) => false,
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
                        'Kembali ke Menu',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool valueBold;

  const _InfoRow({
    required this.label,
    required this.value,
    this.valueBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black54)),
        Text(
          value,
          style: TextStyle(
            fontWeight: valueBold ? FontWeight.bold : FontWeight.w600,
            color: valueBold ? const Color(0xFF6F4E37) : Colors.black87,
          ),
        ),
      ],
    );
  }
}
