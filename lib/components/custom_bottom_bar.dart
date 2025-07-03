import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30, left: 25, right: 25),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // White background
        borderRadius: BorderRadius.circular(30), // Rounded corners
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3), // Shadow color
            spreadRadius: 5,
            blurRadius: 10, // Blur radius for smoothness
            offset: const Offset(0, 3), // Position of the shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildBottomBarItem(
            icon: Icons.calendar_month,
            label: 'Calendar',
            index: 0,
            onTap: onTap,
          ),
          _buildBottomBarItem(
            icon: Icons.person,
            label: 'Profile',
            index: 1,
            onTap: onTap,
          ),
          _buildBottomBarItem(
            icon: Icons.notifications,
            label: 'Notifications',
            index: 2,
            onTap: onTap,
          ),
          _buildBottomBarItem(
            icon: Icons.account_balance_wallet,
            label: 'Wallet',
            index: 3,
            onTap: onTap,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBarItem({
    required IconData icon,
    required String label,
    required int index,
    required Function(int) onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 23,
            color: const Color.fromARGB(220, 0, 0, 0),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 8,
            ),
          ),
        ],
      ),
    );
  }
}
