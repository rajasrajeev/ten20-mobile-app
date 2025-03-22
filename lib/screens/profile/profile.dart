import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ten20/components/custom_layout_inner.dart';

import '../../utils/constants.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String firstName = '';
  String lastName = '';
  String email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString('firstName') ?? '';
      lastName = prefs.getString('lastName') ?? '';
      email = prefs.getString('email') ?? '';
    });
  }

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
                  const SizedBox(height: 16),
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/user.png'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$firstName $lastName',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    '$email',
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
            SizedBox(height: 10)
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
        title: Text(title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              Future.delayed(const Duration(seconds: 1), () {
                Navigator.of(context).pop();
                showAlert(context,
                    title: "Maintenance", message: "Something Went Wrong");
              });
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          );
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
