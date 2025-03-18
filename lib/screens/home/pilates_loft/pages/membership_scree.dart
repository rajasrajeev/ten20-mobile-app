import 'package:flutter/material.dart';
import 'package:ten20/components/custom_layout_inner.dart';
import 'package:ten20/components/service_card.dart';
import 'package:ten20/model/service_item.dart';
// import 'package:ten20/screens/home/pilates_loft/pages/assistant_screen.dart';
import 'package:ten20/utils/constants.dart';

class MembershipScreen extends StatelessWidget {
  const MembershipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();
    final List<ServiceItem> services = [];
    return CustomLayout(
        title: 'Pilates',
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
                  const Text('Select Membership', style: contentHeader)
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
                          title: service.title,
                          description: service.description,
                          price: service.price,
                          height: 130),
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
