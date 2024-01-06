import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  final String? category;
  final String? icon;
  final bool isSelected;

  CategoryTile({
    required this.category,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: (20)),
      margin: EdgeInsets.only(bottom: 10),
      height: size.height * 0.07,
      width: size.width * 0.95,
      decoration: BoxDecoration(
        color: isSelected ? Colors.white.withOpacity(0.2) : Colors.transparent,
        border: Border.all(
          color: isSelected ? Colors.white.withOpacity(0.5) : Color(0xFF80899A),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image.asset(
          icon ?? '',
          width: isSelected ? 30 : 25,
          color: isSelected ? Colors.white : Color(0xFF80899A),
        ),
        SizedBox(width: size.width * 0.005),
        Text(
          category ?? '',
          style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              fontSize: 20,
              color: isSelected ? Colors.white : Color(0xFF80899A),
              letterSpacing: 2),
        ),
      ]),
    );
  }
}
