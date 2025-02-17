import 'package:flutter/material.dart';
import 'package:ten20/components/custom_button.dart';
import 'package:ten20/screens/home/home_screen.dart';
import 'package:ten20/utils/constants.dart';

class OrderFinalScreen extends StatelessWidget {
  const OrderFinalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // Ensure content is spaced between top and bottom
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 200,
                    child: Stack(
                      alignment: Alignment.center, // Center the stack content
                      children: [
                        Image.asset(
                          'assets/icons/nails_diner.png', // Replace with the path to your heart image
                          fit: BoxFit.cover, // Adjust the image fit as needed
                        ),
                        const Positioned(
                          top: 50,
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Adding space between stack and text
                  const Text(
                    'Order Successful',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
                30, 0, 30, 30), // Padding at the bottom
            child: CustomButton(
              bgColor: const Color.fromARGB(255, 0, 10, 20),
              borderRadius: 50.0,
              bgIconColor: const Color.fromARGB(255, 0, 10, 20),
              bgTextColor: Colors.white,
              title: "Home",
              icon: Icons.schedule_send_outlined,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomeScreen()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
