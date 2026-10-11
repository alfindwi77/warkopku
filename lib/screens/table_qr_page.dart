import 'package:flutter/material.dart';

import '../models/table_manager.dart';
import 'home_page.dart';

class TableQrPage extends StatelessWidget {
  const TableQrPage({super.key});

  final List<String> tables = const [
    'Meja 01',
    'Meja 02',
    'Meja 03',
    'Meja 04',
    'Meja 05',
    'Meja 06',
    'Meja 07',
    'Meja 08',
  ];

  void selectTable(BuildContext context, String tableNumber) {
    TableManager.instance.setTable(tableNumber);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Scan QR Meja')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 10),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0E6DC),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.qr_code_2,
                    size: 110,
                    color: Color(0xFF6F4E37),
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  'Simulasi Scan QR Meja',
                  style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),

                const Text(
                  'Pilih nomor meja untuk mensimulasikan '
                  'hasil scan QR Code.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, height: 1.4),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Pilih Meja',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: tables.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.8,
            ),
            itemBuilder: (context, index) {
              final table = tables[index];

              return Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                child: InkWell(
                  onTap: () => selectTable(context, table),
                  borderRadius: BorderRadius.circular(14),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0xFFE5D8CA)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.table_restaurant,
                          color: Color(0xFF6F4E37),
                          size: 28,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          table,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 20),

          const Text(
            'Pada implementasi sebenarnya, pelanggan cukup '
            'memindai QR Code yang tersedia di meja.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.black45, height: 1.4),
          ),
        ],
      ),
    );
  }
}
