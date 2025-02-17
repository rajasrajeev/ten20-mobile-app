// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ten20/components/custom_button.dart';
import 'package:ten20/screens/auth/register.dart';
import 'package:ten20/screens/home/home_screen.dart';
import 'package:ten20/utils/api_service.dart';
import 'package:ten20/utils/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final ApiService apiService = ApiService();
  bool _isHidden = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadUserId();
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              const HomeScreen())); // Replace with your home screen
    }
  }

  void login(BuildContext context) async {
    try {
      if (_controller.text.isNotEmpty && _controller2.text.isNotEmpty) {
        var result =
            await apiService.login(_controller.text, _controller2.text);
        print("data ===> login");
        print(result);
        if (result is Map && result.containsKey('id')) {
          saveUserId(result['id'].toString());
          showAlert(context,
              title: "Success", message: "You have logged in successfully");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          showAlert(context,
              title: "Failed", message: "Username or Password is incorrect");
        }
        print("Result ====> ");
        print(result.toString());
      } else {
        showAlert(context,
            title: "Error",
            message: "Password and Confirm Password Doesnt Match");
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 100),
            Padding(
              padding: const EdgeInsets.only(left: 100),
              child: SizedBox(
                height: MediaQuery.of(context).size.width / 3,
                child: Image.asset(
                  'assets/images/splash_screen_image.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(70, 0, 30, 0),
              child: Text(
                'Sign in to your account',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Text(
                'Email',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextField(
                controller: _controller,
                style: const TextStyle(
                  fontFamily: 'Sunflora', // Apply the custom font
                  fontSize: 18.0,
                  color: Colors.black, // Text color
                ),
                decoration: InputDecoration(
                  hintText: 'Email here',
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
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
              child: Text(
                'Password',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: TextField(
                controller: _controller2,
                obscureText: _isHidden ? true : false, // This hides the text

                style: const TextStyle(
                  fontFamily: 'Sunflora', // Apply the custom font
                  fontSize: 18.0,
                  color: Colors.black, // Text color
                ),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _isHidden = !_isHidden;
                      });
                    },
                  ),
                  hintText: 'Password here',
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
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: CustomButton(
                bgColor: kNailsDinerColor,
                borderRadius: 50.0,
                bgIconColor: Colors.black,
                bgTextColor: Colors.black,
                title: "Continue",
                icon: Icons.arrow_forward,
                onPressed: () {
                  if (_controller.text.isNotEmpty &&
                      _controller2.text.isNotEmpty) {
                    login(context);
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Don’t have an account? ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 117, 117, 117)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                          fontSize: 18, color: Color.fromARGB(255, 0, 70, 67)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
