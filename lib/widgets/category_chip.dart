import 'package:flutter/material.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const CategoryChip({
    super.key,
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        selected: selected,
        onSelected: (_) => onTap(),
        avatar: Icon(
          icon,
          size: 18,
          color: selected ? Colors.white : const Color(0xFF6F4E37),
        ),
        label: Text(label),
        labelStyle: TextStyle(
          color: selected ? Colors.white : const Color(0xFF4A4038),
          fontWeight: FontWeight.w600,
        ),
        selectedColor: const Color(0xFF6F4E37),
        backgroundColor: Colors.white,
        side: BorderSide(
          color: selected ? const Color(0xFF6F4E37) : const Color(0xFFE5D8CA),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        showCheckmark: false,
      ),
    );
  }
}
