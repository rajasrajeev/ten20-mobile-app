import 'package:flutter/material.dart';
import 'package:ten20/utils/constants.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final double height;
  final Color bgColor;
  final bool isSelected;

  const CategoryCard(
      {super.key,
      required this.title,
      this.height = 50,
      this.bgColor = const Color.fromARGB(255, 255, 255, 255),
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: isSelected
          ? const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0)
          : const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: SizedBox(
        height: height,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: isSelected
                    ? Color.fromARGB(255, 0, 0, 0)
                    : Color.fromARGB(255, 255, 255, 255),
                width: isSelected ? 1.0 : 1.0,
              ),
              borderRadius: BorderRadius.circular(15),
              color: isSelected
                  ? bgColor
                  : const Color.fromARGB(255, 255, 255, 255)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: isSelected ? contentHeader4 : contentHeader3,
                      ),
                      const SizedBox(height: 2.0),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios,
                    size: isSelected ? 16 : 12.0,
                    color: isSelected
                        ? const Color.fromARGB(255, 255, 255, 255)
                        : const Color.fromARGB(255, 0, 0, 0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
