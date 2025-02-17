import 'package:flutter/material.dart';
import 'package:ten20/components/custom_button.dart';
import 'package:ten20/screens/auth/register.dart';
import 'package:ten20/utils/constants.dart';

class SplashContinue extends StatefulWidget {
  const SplashContinue({super.key});

  @override
  State<SplashContinue> createState() => _SplashContinueState();
}

class _SplashContinueState extends State<SplashContinue> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 120),
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              child: Image.asset(
                'assets/images/splash_screen_image.png',
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Please Enter your Name',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(30),
              child: TextField(
                controller: _controller,
                style: const TextStyle(
                  fontFamily: 'Sunflora', // Apply the custom font
                  fontSize: 18.0,
                  color: Colors.black, // Text color
                ),
                decoration: InputDecoration(
                  hintText: 'Name here',
                  hintStyle: const TextStyle(
                    fontFamily: 'Sunflora',
                    fontSize: 18.0,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 196, 196, 196),
                        width: 2.0), // Border color
                    borderRadius: BorderRadius.circular(12.0), // Border radius
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 196, 196, 196),
                        width: 2.0), // Border color when focused
                    borderRadius: BorderRadius.circular(12.0), // Border radius
                  ),
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 196, 196, 196),
                        width: 2.0), // Default border color
                    borderRadius:
                        BorderRadius.circular(12.0), // Default border radius
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
              child: CustomButton(
                bgColor: kNailsDinerColor,
                borderRadius: 50.0,
                bgIconColor: Colors.black,
                bgTextColor: Colors.black,
                title: "Continue",
                icon: Icons.arrow_forward,
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>
                            Register(name: _controller.text)));
                  } else {}
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
