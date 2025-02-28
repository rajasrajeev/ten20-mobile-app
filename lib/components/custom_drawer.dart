import 'package:flutter/material.dart';
import 'package:ten20/screens/favorites/favorites.dart';
import 'package:ten20/screens/notifications/notifications.dart';
import 'package:ten20/screens/profile/profile.dart';
import 'package:ten20/screens/wallet/wallet.dart';
import 'package:ten20/utils/constants.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7, // 70% of screen width
      child: Drawer(
        backgroundColor: mainBgColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: kNailsDinerColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/images/assistants/1.png'), // Your profile image
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Sunaina',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text('Favorites'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoritesScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationsScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.wallet),
              title: const Text('Wallet'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
