// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ten20/screens/home/pilates_loft/components/category_card.dart';
import 'package:ten20/components/custom_layout_inner.dart';
import 'package:ten20/model/category_item.dart';
import 'package:ten20/screens/home/pilates_loft/pages/sub_services.dart';
import 'package:ten20/utils/api_service.dart';
import 'package:ten20/utils/constants.dart';

class PilatesLoftPage extends StatefulWidget {
  int id;
  PilatesLoftPage({
    super.key,
    required this.id,
  });

  @override
  State<PilatesLoftPage> createState() => _PilatesLoftPageState();
}

class _PilatesLoftPageState extends State<PilatesLoftPage> {
  DateTime selectedDate = DateTime.now();
  late ApiService apiService;
  late TextEditingController _controller;
  List<CategoryItem> services = [];
  int? isSelected;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    isSelected = DateTime.now().day;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToSelectedDate();
    });
    apiService = ApiService();
    _controller = TextEditingController();
    getServices();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
        var result = await apiService.get_categories(widget.id, changeValue);

        if (result.isNotEmpty) {
          List<CategoryItem> serviceItems = result.map<CategoryItem>((data) {
            return CategoryItem(id: int.parse(data['id']), title: data['name']);
          }).toList();

          setState(() {
            services = serviceItems;
          });
        }
      } else {
        getServices();
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  void scrollToSelectedDate() {
    // Each date container is 60 pixels wide with 10 pixels spacing (5+5 margin)
    double position = (selectedDate.day - 1) * 56.0;
    _scrollController.animateTo(
      position,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  List<Widget> buildDateList() {
    int daysInMonth =
        DateTime(selectedDate.year, selectedDate.month + 1, 0).day;
    List<Widget> dateWidgets = [];

    for (int i = 1; i <= daysInMonth; i++) {
      DateTime date = DateTime(selectedDate.year, selectedDate.month, i);

      dateWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = date;
              isSelected = i;
              scrollToSelectedDate();
            });
          },
          child: Container(
            width: 50,
            // height: 20,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: isSelected == i
                  ? const Color.fromARGB(255, 162, 167, 123)
                  : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: isSelected == i
                  ? Border.all(color: const Color.fromARGB(255, 162, 167, 123))
                  : Border.all(color: Colors.white),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.d().format(date),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: isSelected == i
                        ? Colors.white
                        : const Color.fromARGB(255, 162, 167, 123),
                  ),
                ),
                Text(
                  DateFormat.E().format(date).toUpperCase(),
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected == i
                        ? Colors.white
                        : const Color.fromARGB(255, 162, 167, 123),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return dateWidgets;
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
                const Text('Select Categories', style: contentHeader)
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
              child: Container(
                height: 45,
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
            ),
            const SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.only(left: 5, right: 10, top: 0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/images/splash_screen_image.png',
                        width: 90,
                        height: 90,
                      ),
                      const Text(
                        "Welcome to our Pilates studio — a calm, empowering space where movement meets mindfulness. Personalized sessions, expert guidance, and a focus on strength from within.",
                        style: TextStyle(
                            color: Color.fromARGB(255, 131, 135, 100),
                            fontSize: 13,
                            fontFamily: 'Aromatica'),
                      ),
                    ],
                  ),
                )),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
              height: 70,
              child: ListView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                children: buildDateList(),
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
                        time: "09:00",
                        period: "50 Mins",
                        imageUrl: "",
                        amount: "100 QR",
                        isSelected: isSelected == service.id,
                      ));
                },
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      title: 'Pilates Studio',
    );
  }
}
