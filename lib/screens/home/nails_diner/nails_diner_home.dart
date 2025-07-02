// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ten20/components/category_card.dart';
import 'package:ten20/components/custom_layout_inner.dart';
import 'package:ten20/model/category_item.dart';
import 'package:ten20/screens/home/nails_diner/page/sub_service.dart';
import 'package:ten20/utils/api_service.dart';
import 'package:ten20/utils/constants.dart';

class NailsDinerPage extends StatefulWidget {
  int id;
  NailsDinerPage({required this.id, super.key});

  @override
  State<NailsDinerPage> createState() => _NailsDinerPageState();
}

class _NailsDinerPageState extends State<NailsDinerPage> {
  final ApiService apiService = ApiService();
  final TextEditingController _controller = TextEditingController();
  List<CategoryItem> services = [];
  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    getServices();
  }

  void getServices() async {
    try {
      var result = await apiService.get_categories(widget.id, null);

      if (result.isNotEmpty) {
        // Map each dynamic item to a ServiceItem instance
        List<CategoryItem> serviceItems = result.map<CategoryItem>((data) {
          return CategoryItem(id: int.parse(data['id']), title: data['name']);
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
        var result = await apiService.get_categories(widget.id, changeValue);

        if (result.isNotEmpty) {
          // Process the response data
          print("Data fetched successfully: $result");
          List<CategoryItem> serviceItems = result.map<CategoryItem>((data) {
            return CategoryItem(id: int.parse(data['id']), title: data['name']);
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
                const Text('Select Categories', style: contentHeader),
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
            Padding(
                padding: const EdgeInsets.only(left: 40, right: 40, top: 5),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/splash_screen_image.png',
                        width: 75,
                        height: 75,
                      ),
                      const Center(
                        child: Text(
                          "Welcome to Ten 20 Nails Diner where beauty meets comfort! Indulge in flawless nails while you relax, sip, and unwind in our cozy, chic space designed for self-care with a twist",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 131, 135, 100),
                              fontSize: 10,
                              fontFamily: 'Aromatica'),
                        ),
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
                      setState(() {
                        selectedCategoryId = service.id;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SubServicePage(
                              id: widget.id, selectedServiceId: service.id)));
                    },
                    child: CategoryCard(
                      title: service.title,
                      bgColor: kNailsDinerColor,
                      isSelected: selectedCategoryId == service.id,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      title: 'Nails Diner',
    );
  }
}
