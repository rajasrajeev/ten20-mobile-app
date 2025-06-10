// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:ten20/components/custom_button.dart';
import 'package:ten20/components/custom_layout_inner.dart';
// import 'package:ten20/screens/home/hair_bar/pages/order_final_screen.dart';
import 'package:ten20/screens/home/hair_bar/pages/payment_screen2.dart';
// import 'package:ten20/components/service_card.dart';
// import 'package:ten20/screens/home/hair_bar/page/order_final_screen.dart';
import 'package:ten20/utils/api_service.dart';
// import 'package:ten20/screens/home/nails_diner/page/payment_screen.dart';
import 'package:ten20/utils/constants.dart';

class AppointmentScreen extends StatefulWidget {
  int id;
  int selectedServiceId;
  AppointmentScreen({
    super.key,
    required this.id,
    required this.selectedServiceId,
  });

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  final ApiService apiService = ApiService();
  final ScrollController _scrollController = ScrollController();
  int? isSelected;
  String selectedTime = '12:00 PM';

  List<Map<String, dynamic>> timeSlots = [];

  void getTimeSlots() async {
    print("called here ==>");
    try {
      var result = await apiService.get_time_slots(
          "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}");
      print("========> $result");

      if (result.isNotEmpty) {
        // Map each item in `result` to the desired time slot format
        List<Map<String, dynamic>> timeSlot =
            result.map<Map<String, dynamic>>((data) {
          return {
            'time':
                data['time'], // Assuming 'time' is a key in your API response
            'enabled':
                true, // You can set the enabled field based on your logic
          };
        }).toList();
        print("========>time slot=============> $timeSlot");
        if (timeSlot.isNotEmpty) {
          timeSlots = [];
          setState(() {
            // Here you can save the timeSlots to a state variable if you have one
            timeSlots =
                timeSlot; // Make sure to declare timeSlots in your class
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
    getTimeSlots();
  }

  @override
  Widget build(BuildContext context) {
    void scrollToSelectedDate() {
      // Each date container is 60 pixels wide with 10 pixels spacing (5+5 margin)
      double position = (selectedDate.day - 1) * 70.0;
      _scrollController.animateTo(
        position,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    @override
    void initState() {
      super.initState();
      isSelected = DateTime.now().day;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollToSelectedDate();
      });
    }

    void selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );

      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate = picked;
        });
      }
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
              getTimeSlots();
              setState(() {
                selectedDate = date;
                isSelected = i;
                scrollToSelectedDate();
              });
            },
            child: Container(
              width: 60,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                color: isSelected == i ? kNailsDinerColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: isSelected == i
                    ? Border.all(color: kNailsDinerColor)
                    : Border.all(color: Colors.white),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.d().format(date),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        fontFamily: "CeraPro",
                        color: isSelected == i
                            ? Colors.white
                            : kDefaultBgTextColor),
                  ),
                  Text(
                    DateFormat.E().format(date).toUpperCase(),
                    style: TextStyle(
                        fontSize: 14,
                        fontFamily: "CeraPro",
                        fontWeight: FontWeight.w400,
                        color: isSelected == i
                            ? Colors.white
                            : kDefaultBgTextColor),
                  ),
                ],
              ),
            ),
          ),
        );
      }

      return dateWidgets;
    }

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
                  const Text('Select Appointment', style: contentHeader)
                ],
              ),
              const SizedBox(height: 10),
              const SizedBox(height: 10),
              Row(
                children: <Widget>[
                  Text(DateFormat.yMMMM().format(selectedDate).toString(),
                      style: contentHeader),
                  GestureDetector(
                    onTap: () {
                      selectDate(context);
                    },
                    child: const Icon(
                      Icons.arrow_drop_down_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                height: 80,
                child: ListView(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  children: buildDateList(),
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Text('Available Time Slots', style: contentHeader),
                ],
              ),
              Expanded(
                child: SizedBox(
                  // Adjust height based on your row height (e.g., 60.0 per row)
                  height: 3 * 60.0,
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 9,
                      crossAxisSpacing: 6,
                      childAspectRatio: 3.5,
                    ),
                    itemCount: timeSlots.length,
                    itemBuilder: (context, index) {
                      final slot = timeSlots[index];
                      final isSelected = selectedTime == slot['time'];
                      final isEnabled = slot['enabled'];

                      return GestureDetector(
                        onTap: isEnabled
                            ? () {
                                setState(() {
                                  selectedTime = slot['time'];
                                });
                              }
                            : null,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? kNailsDinerColor
                                : isEnabled
                                    ? Colors.white
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(color: kNailsDinerColor)
                                : isEnabled
                                    ? Border.all(color: Colors.white)
                                    : Border.all(color: Colors.grey[300]!),
                          ),
                          child: Text(
                            slot['time'],
                            style: TextStyle(
                              fontFamily: "CeraPro",
                              color: isEnabled
                                  ? isSelected
                                      ? kDefaultBgTextColor
                                      : kDefaultBgTextColor
                                  : Color.fromARGB(255, 88, 88, 88),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 200),
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                child: CustomButton(
                  bgColor: kNailsDinerColor,
                  borderRadius: 50.0,
                  bgIconColor: Colors.white,
                  bgTextColor: Colors.white,
                  title: "Book Slot",
                  icon: Icons.schedule_send_outlined,
                  vertical: 10.0,
                  horizontal: 5.0,
                  onPressed: () {
                    // showDialog(
                    //   context: context,
                    //   barrierDismissible: false,
                    //   builder: (BuildContext context) {
                    //     Future.delayed(const Duration(seconds: 2), () {
                    //       Navigator.of(context).pop();
                    //       showAlert(context,
                    //           title: "Success",
                    //           message: "Appointment Successful!!!");
                    //       );
                    //     });
                    //     return const Center(
                    //       child: CircularProgressIndicator(),
                    //     );
                    //   },
                    // );
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentScreen2Page(id: 1)));
                  },
                ),
              )
            ],
          ),
        ),
        title: "Hair Bar");
  }
}
