// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:ten20/utils/constants.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  bool isTitleEnabled;
  String title;
  CustomAppBar({super.key, this.isTitleEnabled = false, required this.title});

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool showProfileImage = true;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: mainBgColor, // Matches the background color
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Opens the drawer
        },
      ),
      title: widget.isTitleEnabled
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Logo and text side by side
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            )
          : SizedBox(
              width: 250,
              height: 50,
              child: Image.asset(
                'assets/images/splash_screen_image.png',
                fit: BoxFit.fitHeight,
              ),
            ),
      actions: [
        // IconButton(
        //   icon: showProfileImage
        //       ? const CircleAvatar(
        //           backgroundColor: Colors.white,
        //           child: Text(
        //             "S",
        //             style: TextStyle(color: Colors.black),
        //           ),
        //         )
        //       : const Text(
        //           "Profile",
        //           style: TextStyle(color: Colors.black),
        //         ),
        //   onPressed: () {
        //     setState(() {
        //       showProfileImage = !showProfileImage;
        //     });
        //   },
        // ),
        const SizedBox(width: 16), // Spacing between icon and edge
      ],
    );
  }
}
