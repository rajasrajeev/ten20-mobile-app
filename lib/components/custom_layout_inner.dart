import 'package:flutter/material.dart';
import 'package:ten20/components/custom_app_bar.dart';
import 'package:ten20/components/custom_bottom_bar.dart';
import 'package:ten20/components/custom_drawer.dart';
import 'package:ten20/utils/constants.dart';

class CustomLayout extends StatelessWidget {
  final Widget body;
  final String title;

  const CustomLayout({Key? key, required this.body, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          mainBgColor, // Use your main background color for the content
      drawer: const CustomDrawer(),
      appBar: CustomAppBar(isTitleEnabled: true, title: title),
      body: Stack(
        children: [
          body, // Main content of the screen
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomBar(
              onTap: (index) {
                // Handle navigation based on the index
                switch (index) {
                  case 0:
                    Navigator.pushNamed(context, '/favorites');
                    break;
                  case 1:
                    Navigator.pushNamed(context, '/profile');
                    break;
                  case 2:
                    Navigator.pushNamed(context, '/notifications');
                    break;
                  case 3:
                    Navigator.pushNamed(context, '/wallet');
                    break;
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
