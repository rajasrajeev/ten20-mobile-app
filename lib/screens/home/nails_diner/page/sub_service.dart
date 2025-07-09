// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ten20/components/custom_layout_inner.dart';
import 'package:ten20/components/service_card.dart';
import 'package:ten20/model/service_item.dart';
// import 'package:ten20/screens/home/nails_diner/page/assistant_screen.dart';
import 'package:ten20/screens/home/nails_diner/page/sub_service2.dart';
import 'package:ten20/utils/api_service.dart';
import 'package:ten20/utils/constants.dart';

class SubServicePage extends StatefulWidget {
  int id;
  int selectedServiceId;
  SubServicePage(
      {required this.id, required this.selectedServiceId, super.key});

  @override
  State<SubServicePage> createState() => _SubServicePageState();
}

class _SubServicePageState extends State<SubServicePage> {
  final ApiService apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  List<ServiceItem> services = [];
  int? isSelectedId;

  @override
  void initState() {
    super.initState();
    print("called"); // Debugging print statement
    getServices();
  }

  void getServices() async {
    print("called here ==>");
    try {
      var result = await apiService.get_sub_services(widget.selectedServiceId);
      print(result);

      if (result.isNotEmpty) {
        // Map each dynamic item to a ServiceItem instance
        List<ServiceItem> serviceItems = result.map<ServiceItem>((data) {
          return ServiceItem(
            id: int.parse(data['id']),
            imageUrl: "$imageUrl/${data['image']}",
            title: data['name'],
            price: data['price'],
            description: data['description'],
          );
        }).toList();

        if (serviceItems.isNotEmpty) {
          loadUserId();
          setState(() {
            services = serviceItems;
          });
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void fetchDataOnTextChange(String changeValue) async {
    try {
      if (changeValue.isNotEmpty) {
        // If there's a search term, fetch filtered sub-services
        var result =
            await apiService.get_sub_services_s(widget.id, changeValue);

        if (result.isNotEmpty) {
          // Process the response data
          print("Data fetched successfully: $result");
          List<ServiceItem> serviceItems = result.map<ServiceItem>((data) {
            return ServiceItem(
              id: int.parse(data['id']),
              imageUrl: "$imageUrl/${data['image']}",
              title: data['name'],
              price: data['price'],
              description: data['description'],
            );
          }).toList();

          setState(() {
            services = serviceItems;
          });
        }
      } else {
        // If the search term is empty, fetch all services
        getServices();
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
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
                const Text('Select Service', style: contentHeader),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 10, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: TextField(
                    controller: _controller,
                    onChanged: fetchDataOnTextChange,
                    textAlignVertical:
                        TextAlignVertical.center, // Ensures vertical centering
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 15,
                        color: Color.fromRGBO(107, 119, 154, 1),
                      ),
                      hintText: 'Search here',
                      hintStyle: const TextStyle(
                        color: Color.fromRGBO(107, 119, 154, 0.5),
                        fontFamily: 'Aromatica',
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10), // Adjust as needed
                    ),
                    style: const TextStyle(
                      color: Color.fromRGBO(107, 119, 154, 0.5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Choose Your Service',
              style: TextStyle(
                fontSize: 16,
                color: kDefaultBgTextColor,
                fontFamily: 'Aromatica',
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
                      setState(() {
                        isSelectedId = service.id;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SubService2Page(
                              id: widget.id,
                              selectedServiceId: widget.selectedServiceId,
                              selectedSubServiceId: service.id)));
                    },
                    child: ServiceCard(
                      bgColor: kNailsDinerColor,
                      isSelected: isSelectedId == service.id,
                      imageUrl: service.imageUrl,
                      title: service.title,
                      price: service.price,
                      description: service.description,
                      height: 140,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      title: 'Nails Diner',
    );
  }
}
