import 'package:flutter/material.dart';
import 'package:ten20/utils/constants.dart';

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final double height;
  final String price;

  const ServiceCard(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.description,
      this.price = "",
      this.height = 110.0});

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
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    imageUrl,
                    width: 120.0,
                    height: 70.0,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10.0),
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
                      Text(
                        description,
                        style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.grey[600],
                            fontFamily: 'CeraPro'),
                      ),
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
