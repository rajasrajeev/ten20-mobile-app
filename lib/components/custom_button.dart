import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Color bgColor;
  final Color bgTextColor;
  final Color bgIconColor;
  final double borderRadius;
  final String title;
  final IconData icon;
  final double vertical;
  final double horizontal;

  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.bgColor,
      required this.bgIconColor,
      required this.bgTextColor,
      required this.borderRadius,
      required this.title,
      required this.icon,
      this.vertical = 16.0,
      this.horizontal = 24.0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // Call the passed function when the button is tapped
      child: Container(
        width: double.infinity, // Make the button fill the parent's width
        padding:
            EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
        decoration: BoxDecoration(
          color: bgColor, // Background color
          borderRadius: BorderRadius.circular(borderRadius), // Rounded corners
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              offset: Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Sunflora', // Use the custom font
                fontSize: 18.0,
                color: bgTextColor, // Text color
              ),
            ),
            const SizedBox(width: 8.0),
            bgIconColor == bgColor
                ? Icon(
                    icon,
                    color: bgIconColor, // Icon color
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
