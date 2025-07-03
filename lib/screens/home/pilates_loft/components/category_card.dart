// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final String? time;
  final String? period;
  final String? amount;
  final String? imageUrl;
  final bool isSelected;

  const CategoryCard({
    super.key,
    required this.title,
    this.time,
    this.period = "50 Mins",
    this.amount,
    this.imageUrl,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    const Color selectedColor = Color.fromARGB(255, 162, 167, 123);
    const Color unselectedColor = Colors.white;
    const Color selectedTextColor = Colors.white;
    const Color unselectedTextColor = Color.fromARGB(255, 162, 167, 123);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? selectedColor : unselectedColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Time
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              time ?? "",
              style: TextStyle(
                color: isSelected ? selectedTextColor : unselectedTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 11,
                fontFamily: 'Aromatica',
              ),
            ),
          ),
          // Image or colored circle
          Container(
            width: 36,
            height: 36,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: imageUrl == ""
                  ? (isSelected ? unselectedColor : selectedColor)
                  : Colors.transparent,
              border: Border.all(
                color: Colors.transparent,
              ),
              image: imageUrl != ""
                  ? DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
          ),
          // Details
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color:
                          isSelected ? selectedTextColor : unselectedTextColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontFamily: 'Aromatica',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    "Paria Sadat",
                    style: TextStyle(
                      color: isSelected
                          ? selectedTextColor.withOpacity(0.8)
                          : unselectedTextColor.withOpacity(0.8),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Aromatica',
                    ),
                  ),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            textAlign: TextAlign.right,
                            period ?? "50 Mins",
                            style: TextStyle(
                              color: isSelected
                                  ? selectedTextColor
                                  : unselectedTextColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Aromatica',
                            ),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            textAlign: TextAlign.right,
                            amount ?? "170 QR",
                            style: TextStyle(
                              color: isSelected
                                  ? selectedTextColor
                                  : unselectedTextColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Aromatica',
                            ),
                          ),
                        ]),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
