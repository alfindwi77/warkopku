import 'package:flutter/material.dart';
import '../screens/menu_data.dart';

class MenuCard extends StatelessWidget {
  final MenuItemData menu;
  final VoidCallback onTap;

  const MenuCard({
    super.key,
    required this.menu,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  menu.image,
                  width: 82,
                  height: 82,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      menu.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      menu.category,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black45,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      menu.price,
                      style: const TextStyle(
                        color: Color(0xFF6F4E37),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF6F4E37),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
