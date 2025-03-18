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
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
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
                      fontFamily: 'CeraPro'),
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
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  final service = services[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SubServicePage(
                              id: widget.id, selectedServiceId: service.id)));
                    },
                    child: CategoryCard(
                      title: service.title,
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
