// ignore_for_file: must_be_immutable, use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ten20/components/custom_button.dart';
import 'package:ten20/screens/auth/login.dart';
import 'package:ten20/screens/home/home_screen.dart';
import 'package:ten20/utils/api_service.dart';
import 'package:ten20/utils/constants.dart';

class Register extends StatefulWidget {
  String name;
  Register({this.name = "", super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();
  final TextEditingController _controller5 = TextEditingController();
  final ApiService apiService = ApiService();
  bool _isHidden = true;
  bool _isHidden2 = true;
  bool _showPassword = false;
  @override
  void initState() {
    setState(() {
      _controller.text = widget.name;
    });
    loadUserId();
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) =>
              const HomeScreen())); // Replace with your home screen
    }
    super.initState();
  }

  void register(BuildContext context) async {
    try {
      if (_controller4.text == _controller5.text) {
        var result = await apiService.register(_controller.text,
            _controller2.text, _controller3.text, _controller4.text);
        if (result != 0) {
          saveUserId(
              result[0]['id'].toString(),
              result[0]['first_name'].toString(),
              result[0]['last_name'],
              result[0]['address'],
              result[0]['email']);
          showAlert(context,
              title: "Success", message: "You have registered successfully");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()));
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
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.width / 3,
                  child: Image.asset(
                    'assets/images/splash_screen_image.png',
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Text(
                'Create New Account',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  width: (MediaQuery.of(context).size.width / 2) - 70,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: !_showPassword ? Colors.black : Colors.white)),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  width: (MediaQuery.of(context).size.width / 2) - 70,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2,
                          color: _showPassword ? Colors.black : Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            !_showPassword
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                        child: Text(
                          'Your Name',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: TextField(
                          controller: _controller,
                          style: const TextStyle(
                            fontFamily: 'Aromatica', // Apply the custom font
                            fontSize: 18.0,
                            color: Colors.black, // Text color
                          ),
                          decoration: InputDecoration(
                            hintText: 'Name here',
                            hintStyle: const TextStyle(
                              fontFamily: 'Aromatica',
                              fontSize: 18.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color when focused
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Default border color
                              borderRadius: BorderRadius.circular(
                                  12.0), // Default border radius
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                        child: Text(
                          'Email Address',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: TextField(
                          controller: _controller2,
                          // obscureText: true, // This hides the text

                          style: const TextStyle(
                            fontFamily: 'Aromatica', // Apply the custom font
                            fontSize: 18.0,
                            color: Colors.black, // Text color
                          ),
                          decoration: InputDecoration(
                            hintText: '',
                            hintStyle: const TextStyle(
                              fontFamily: 'Aromatica',
                              fontSize: 18.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color when focused
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Default border color
                              borderRadius: BorderRadius.circular(
                                  12.0), // Default border radius
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                        child: Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: TextField(
                          controller: _controller3,
                          obscureText: false, // This hides the text

                          style: const TextStyle(
                            fontFamily: 'Aromatica', // Apply the custom font
                            fontSize: 18.0,
                            color: Colors.black, // Text color
                          ),
                          decoration: InputDecoration(
                            hintText: '',
                            hintStyle: const TextStyle(
                              fontFamily: 'Aromatica',
                              fontSize: 18.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color when focused
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Default border color
                              borderRadius: BorderRadius.circular(
                                  12.0), // Default border radius
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
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
                          controller: _controller4,
                          obscureText: _isHidden,
                          style: const TextStyle(
                            fontFamily: 'Aromatica', // Apply the custom font
                            fontSize: 18.0,
                            color: Colors.black, // Text color
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_isHidden
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isHidden = !_isHidden;
                                });
                              },
                            ),
                            hintText: '',
                            hintStyle: const TextStyle(
                              fontFamily: 'Aromatica',
                              fontSize: 18.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color when focused
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Default border color
                              borderRadius: BorderRadius.circular(
                                  12.0), // Default border radius
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(30, 5, 30, 0),
                        child: Text(
                          'Confirm Password',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                        child: TextField(
                          controller: _controller5,
                          obscureText: _isHidden2, // This hides the text

                          style: const TextStyle(
                            fontFamily: 'Aromatica', // Apply the custom font
                            fontSize: 18.0,
                            color: Colors.black, // Text color
                          ),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(_isHidden2
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onPressed: () {
                                setState(() {
                                  _isHidden2 = !_isHidden2;
                                });
                              },
                            ),
                            hintText: '',
                            hintStyle: const TextStyle(
                              fontFamily: 'Aromatica',
                              fontSize: 18.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Border color when focused
                              borderRadius:
                                  BorderRadius.circular(12.0), // Border radius
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color.fromARGB(255, 196, 196, 196),
                                  width: 2.0), // Default border color
                              borderRadius: BorderRadius.circular(
                                  12.0), // Default border radius
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 16.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
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
                      _controller2.text.isNotEmpty &&
                      _controller3.text.isNotEmpty) {
                    setState(() {
                      _showPassword = true;
                    });
                  }
                  if (_controller4.text.isNotEmpty &&
                      _controller5.text.isNotEmpty) {
                    register(context);
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
                    'Already have an account? ',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 117, 117, 117)),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const Login()));
                    },
                    child: const Text(
                      'Sign In',
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
