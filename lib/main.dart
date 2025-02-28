import 'package:flutter/material.dart';
import 'package:ten20/screens/favorites/favorites.dart';
import 'package:ten20/screens/notifications/notifications.dart';
import 'package:ten20/screens/profile/profile.dart';
import 'package:ten20/screens/splash/splash_screen.dart';
import 'package:ten20/screens/wallet/wallet.dart';
import 'package:ten20/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await loadUserId(); // Load user data before the app starts
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Sunflora", // Use the custom font directly
      ),
      home: const SplashScreen(),
      routes: {
        '/favorites': (context) => FavoritesScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/notifications': (context) => NotificationsScreen(),
        '/wallet': (context) => WalletScreen(),
        // Add other routes here
      },
    );
  }
}
