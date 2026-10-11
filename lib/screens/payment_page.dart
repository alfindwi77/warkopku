import 'package:flutter/material.dart';

import '../models/cart_manager.dart';
import 'order_success_page.dart';

class PaymentPage extends StatefulWidget {
  final String orderType;
  final String tableNumber;
  final String paymentMethod;

  const PaymentPage({
    super.key,
    required this.orderType,
    required this.tableNumber,
    required this.paymentMethod,
  });

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final CartManager cart = CartManager.instance;

  bool isProcessing = false;

  String formatRupiah(int value) {
    return 'Rp${value.toString().replaceAllMapped(RegExp(r'(?=(\d{3})+$)'), (_) => '.')}';
  }

  Future<void> processPayment() async {
    setState(() {
      isProcessing = true;
    });

    // Simulasi proses pembayaran.
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSuccessPage(
          orderType: widget.orderType,
          tableNumber: widget.tableNumber,
          paymentMethod: widget.paymentMethod,
          total: cart.totalPrice,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isQris = widget.paymentMethod == 'QRIS';

    return Scaffold(
      appBar: AppBar(title: const Text('Pembayaran')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                const Text(
                  'Konfirmasi Pembayaran',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Silakan periksa detail pesanan sebelum melanjutkan.',
                  style: TextStyle(color: Colors.black54),
                ),

                const SizedBox(height: 24),

                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _InfoRow(label: 'Jenis Pesanan', value: widget.orderType),
                      const SizedBox(height: 14),
                      _InfoRow(label: 'Meja', value: widget.tableNumber),
                      const SizedBox(height: 14),
                      _InfoRow(
                        label: 'Pembayaran',
                        value: widget.paymentMethod,
                      ),
                      const Divider(height: 28),
                      _InfoRow(
                        label: 'Total',
                        value: formatRupiah(cart.totalPrice),
                        valueBold: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                if (isQris) _buildQrisSection() else _buildCashSection(),
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
                onPressed: isProcessing ? null : processPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6F4E37),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: const Color(0xFFB8A99D),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: isProcessing
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        isQris ? 'Saya Sudah Bayar' : 'Konfirmasi Pembayaran',
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

  Widget _buildQrisSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          const Icon(Icons.qr_code_2, size: 150, color: Colors.black87),

          const SizedBox(height: 16),

          const Text(
            'QRIS Simulasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          const Text(
            'Gunakan QR Code ini sebagai simulasi pembayaran QRIS.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildCashSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: const Column(
        children: [
          Icon(Icons.payments_outlined, size: 70, color: Color(0xFF6F4E37)),

          SizedBox(height: 14),

          Text(
            'Pembayaran Tunai',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 8),

          Text(
            'Pembayaran akan dicatat sebagai pembayaran tunai. '
            'Ini merupakan simulasi dan tidak melibatkan transaksi nyata.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black54, height: 1.4),
          ),
        ],
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
