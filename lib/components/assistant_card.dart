import 'package:flutter/material.dart';

class AssistantCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const AssistantCard({super.key, required this.imageUrl, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(255, 255, 255, 255)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Image.network(
              imageUrl,
              height: 70, // Adjust height to fit your design
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'CeraPro'),
          ),
        ],
      ),
    );
  }
}
