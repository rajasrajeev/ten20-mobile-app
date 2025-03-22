// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ten20/components/assistant_card.dart';
import 'package:ten20/components/custom_layout_inner.dart';
import 'package:ten20/model/service_item.dart';
import 'package:ten20/screens/home/nails_diner/page/appointment_screen.dart';
import 'package:ten20/utils/api_service.dart';
import 'package:ten20/utils/constants.dart';

class AssistantScreen extends StatefulWidget {
  int id;
  int selectedService;
  String price;
  String image;
  String title;
  AssistantScreen(
      {required this.id,
      required this.selectedService,
      required this.price,
      required this.image,
      required this.title,
      super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final ApiService apiService = ApiService();
  List<ServiceItem> assistants = [];

  void getServices() async {
    try {
      var result = await apiService.get_assistants(widget.id);

      if (result.isNotEmpty) {
        // Map each dynamic item to a ServiceItem instance
        List<ServiceItem> serviceItems = result.map<ServiceItem>((data) {
          return ServiceItem(
            id: int.parse(data['id']),
            imageUrl: "$imageUrl/${data['image']}",
            title: data['name'],
            price: "",
            description: "",
          );
        }).toList();

        if (serviceItems.isNotEmpty) {
          loadUserId();
          setState(() {
            assistants = serviceItems;
          });
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getServices();
  }

  @override
  Widget build(BuildContext context) {
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
                  const Text('Select Service Assistant', style: contentHeader)
                ],
              ),
              Expanded(
                  child: GridView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: assistants.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.00, // Adjust this for image scaling
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AppointmentScreen(
                                  id: widget.id,
                                  selectedServiceId: widget.selectedService,
                                  price: widget.price,
                                  imageUrl: widget.image,
                                  serviceName: widget.title,
                                  assistantName: assistants[index].title,
                                )));
                      },
                      child: AssistantCard(
                        imageUrl: assistants[index].imageUrl,
                        title: assistants[index].title,
                        description: assistants[index].description,
                      ));
                },
              ))
            ],
          ),
        ),
        title: 'Nails Diner');
  }
}
