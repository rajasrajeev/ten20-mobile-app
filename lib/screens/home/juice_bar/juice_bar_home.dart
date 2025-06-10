// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ten20/components/custom_layout_inner.dart';
import 'package:ten20/components/service_card.dart';
import 'package:ten20/model/service_item.dart';
// import 'package:ten20/screens/home/juice_bar/pages/assistant_screen.dart';
import 'package:ten20/utils/constants.dart';

class JuiceBarPage extends StatelessWidget {
  int id;
  JuiceBarPage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final List<ServiceItem> services = [];
    return CustomLayout(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 5, 10, 10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                  const Text('Select Drink Category', style: contentHeader)
                ],
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white, // Background color
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color.fromRGBO(107, 119, 154, 1), // Icon color
                    ),
                    hintText: 'Search here',
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(107, 119, 154, 0.5), // Text color
                        fontFamily: 'CeraPro'),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none, // Default border color
                      borderRadius:
                          BorderRadius.circular(12.0), // Default border radius
                    ),
                  ),
                  style: const TextStyle(
                    color: Color.fromRGBO(107, 119, 154, 0.5), // Text color
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(left: 5, right: 10, top: 5),
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/splash_screen_image.png',
                          width: 100,
                          height: 100,
                        ),
                        const Text(
                          "Fuel your body, refresh your mind. Our in-studio juice bar offers a curated selection of cold-pressed juices, wellness shots, and nutrient-packed smoothies—perfect for a post-workout boost or a healthy treat any time. Each blend is crafted with fresh, seasonal ingredients to support your energy, hydration, and glow from the inside out.",
                          style: TextStyle(
                              color: Color.fromARGB(255, 131, 135, 100),
                              fontSize: 10,
                              fontFamily: 'CeraPro'),
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const AssistantScreen()));
                      },
                      child: ServiceCard(
                        imageUrl: service.imageUrl,
                        price: service.price,
                        title: service.title,
                        description: service.description,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        title: 'Juice Bar');
  }
}
