// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ten20/components/custom_layout_inner.dart';
// import 'package:ten20/components/service_card.dart';
import 'package:ten20/model/service_item.dart';
import 'package:ten20/screens/home/pilates_loft/pages/assistant_screen.dart';
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
        title: "Pilates Studio",
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Top bar with back and title
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
                    const SizedBox(width: 8),
                    const Text('Select Categories', style: contentHeader),
                  ],
                ),
                const SizedBox(height: 14),
                // Search bar
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: TextField(
                    controller: _controller,
                    onChanged: fetchDataOnTextChange,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color.fromRGBO(107, 119, 154, 1),
                      ),
                      hintText: 'Search here',
                      hintStyle: const TextStyle(
                          color: Color.fromRGBO(107, 119, 154, 0.5),
                          fontFamily: 'Aromatica'),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                    style: const TextStyle(
                      color: Color.fromRGBO(107, 119, 154, 0.5),
                    ),
                  ),
                ),
                // Service card preview (first item)
                if (services.isNotEmpty)
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: const Color(0xFFF8F2EF),
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              services[0].imageUrl,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Title and time
                          Text(
                            services[0].title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.access_time,
                                  size: 16, color: Colors.grey),
                              const SizedBox(width: 4),
                              Text(
                                "09:00  |  Fri. 8. Apr",
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Spots
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Row(
                              // mainAxisSize: MainAxisSize.min,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Spots",
                                  style: TextStyle(
                                    color: Color(0xFF6B799A),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Text(
                                  "3/8",
                                  style: TextStyle(
                                    color: Color(0xFF6B799A),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Instructor
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFB7B89F),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Paria Sadat",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      "Pilates Instructor",
                                      style: TextStyle(
                                        color: Color(0xFF6B799A),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "View Profile",
                                    style: TextStyle(
                                      color: Color(0xFF6B799A),
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Description
                          const Text(
                            "Description",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '“Welcome to our boutique Pilates studio – a calm, empowering space where movement meets mindfulness. Personalized sessions, expert guidance, and a focus on strength from within.”',
                            style: TextStyle(
                              color: Color(0xFF6B799A),
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Book Slot Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFB7B89F),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: () {
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => AssistantScreen(
                                //     id: widget.id,
                                //     selectedService: services[0].id,
                                //     price: services[0].price,
                                //     image: services[0].imageUrl,
                                //     title: services[0].title,
                                //   ),
                                // ));
                              },
                              child: Text(
                                "Book Slot - ${services[0].price} QR",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
