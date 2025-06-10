import 'package:flutter/material.dart';
import 'package:ten20/utils/constants.dart';

class ServiceCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String duration;
  final String price;
  final Color bgColor;
  final double height;
  final bool isSelected;

  const ServiceCard({
    super.key,
    required this.imageUrl,
    required this.title,
    this.description =
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    this.duration = "30 min",
    required this.price,
    this.height = 110.0,
    this.bgColor = const Color(0xFFFFFFFF),
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isSelected ? bgColor : Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title
          Text(
            title,
            style: isSelected
                ? contentDescription2()
                : contentDescription(color: kDefaultBgTextColor),
          ),
          const SizedBox(height: 8.0),

          /// Row with image + description
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(
                  imageUrl,
                  width: 60,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  description,
                  style: isSelected
                      ? contentDescription2()
                      : contentDescription(color: kDefaultBgTextColor),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          /// Footer row: Learn More, Duration, Price
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Learn More >",
                style: isSelected
                    ? contentDescription2()
                    : contentDescription(color: kDefaultBgTextColor),
              ),
              Row(
                children: [
                  Text(
                    duration,
                    style: isSelected
                        ? contentDescription2()
                        : contentDescription(color: kDefaultBgTextColor),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    "$price QR",
                    style: isSelected
                        ? contentDescription2()
                        : contentDescription(color: kDefaultBgTextColor),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
