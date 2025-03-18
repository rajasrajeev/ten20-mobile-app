import 'package:flutter/material.dart';
import 'package:ten20/utils/constants.dart';

class CategoryCard extends StatelessWidget {
  final String title;
  final double height;

  const CategoryCard({super.key, required this.title, this.height = 50});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: SizedBox(
        height: height,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 255, 255, 255)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: contentHeader,
                      ),
                      const SizedBox(height: 2.0),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios,
                    color: Color.fromARGB(255, 0, 0, 0)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
