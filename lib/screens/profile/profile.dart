import 'package:flutter/material.dart';
import 'package:ten20/components/custom_layout_inner.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
      title: 'Profile',
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFE6D7E9),
              child: Column(
                children: [
                  const Text(
                    '+ My Profile',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                        'https://randomuser.me/api/portraits/women/44.jpg'),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Jessica Adams',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'jessicaadams@example.com',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),

            // Menu Items
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(
                      context, 'My Orders', Icons.shopping_bag_outlined),
                  _buildMenuItem(
                      context, 'My Cart', Icons.shopping_cart_outlined),
                  _buildMenuItem(
                      context, 'Customer Support', Icons.headset_mic_outlined),
                  _buildMenuItem(context, 'My Wishlist', Icons.favorite_border),
                  _buildMenuItem(context, 'My Reviews', Icons.star_border),
                  _buildMenuItem(
                      context, 'Payment Details', Icons.payment_outlined),
                  _buildMenuItem(
                      context, 'Address', Icons.location_on_outlined),
                  _buildMenuItem(
                      context, 'Delete Account', Icons.delete_outline),
                  _buildMenuItem(context, 'Settings', Icons.settings_outlined),
                  _buildMenuItem(context, 'Logout', Icons.logout),
                ],
              ),
            ),

            // Bottom Navigation
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFFE6D7E9),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.home_outlined, true),
                  _buildNavItem(Icons.search_outlined, false),
                  _buildNavItem(Icons.person_outline, false),
                  _buildNavItem(Icons.menu, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Colors.black54),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {
          // Handle menu item tap
        },
      ),
    );
  }

  Widget _buildNavItem(IconData icon, bool isSelected) {
    return Icon(
      icon,
      color: isSelected ? Colors.black : Colors.black54,
      size: 24,
    );
  }
}
