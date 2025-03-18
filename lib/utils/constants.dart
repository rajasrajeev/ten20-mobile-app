import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Api end point

const String baseUrl = "https://ten20socialclub.connecti-fy.com/admin/Api";
const String imageUrl = "https://ten20socialclub.connecti-fy.com/";
// const String baseUrl =
//     "https://ac4f-2406-8800-81-b3a6-c7ca-a956-5d61-5436.ngrok-free.app/ten20/admin/Api";
// const String imageUrl =
//     "https://ac4f-2406-8800-81-b3a6-c7ca-a956-5d61-5436.ngrok-free.app/ten20/";

// Define color constants
const Color kNailsDinerColor = Color.fromARGB(255, 217, 184, 216);
const Color kHairBarColor = Color.fromARGB(255, 247, 197, 182);
const Color kJuiceBarColor = Color.fromARGB(255, 174, 203, 231);
const Color kPilatesLoftColor = Color.fromARGB(255, 208, 224, 211);

// bg color

const Color mainBgColor = Color.fromARGB(255, 251, 240, 236);

const TextStyle contentHeader = TextStyle(
    color: Colors.black,
    fontFamily: 'CeraPro',
    fontSize: 18,
    fontWeight: FontWeight.w800);
// Define padding/margin constants

// Function to show an alert dialog
void showAlert(BuildContext context,
    {String title = "Alert", String message = "Something went wrong"}) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title, style: contentHeader),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("OK", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  });
}

// Variable to track login status and user ID
bool isLoggedIn = false;
String? userId;

// Function to save user ID and login status
Future<void> saveUserId(String id, String firstName, String lastName,
    String address, String email) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', id);
  await prefs.setString('firstName', firstName);
  await prefs.setString('lastName', lastName);
  await prefs.setString('address', address);
  await prefs.setString('email', email);
  await prefs.setBool('isLoggedIn', true);
  userId = id;
  isLoggedIn = true;
}

// Function to get user ID and login status
Future<void> loadUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  userId = prefs.getString('userId');
  isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
}

// Function to clear user ID and login status (e.g., on logout)
Future<void> clearUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
  await prefs.setBool('isLoggedIn', false);
  userId = null;
  isLoggedIn = false;
}
