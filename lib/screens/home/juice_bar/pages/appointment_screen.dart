import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ten20/components/custom_button.dart';
import 'package:ten20/components/custom_layout_inner.dart';
import 'package:ten20/components/service_card.dart';
import 'package:ten20/screens/home/juice_bar/pages/order_final_screen.dart';
import 'package:ten20/utils/constants.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  DateTime selectedDate = DateTime.now();
  final ScrollController _scrollController = ScrollController();
  int? isSelected;
  String selectedTime = '12:00 PM';

  final List<Map<String, dynamic>> timeSlots = [
    {'time': '09:00 AM', 'enabled': true},
    {'time': '09:30 AM', 'enabled': true},
    {'time': '10:00 AM', 'enabled': true},
    {'time': '10:30 AM', 'enabled': false},
    {'time': '12:00 PM', 'enabled': true},
    {'time': '12:30 PM', 'enabled': true},
    {'time': '01:30 PM', 'enabled': true},
    {'time': '02:00 AM', 'enabled': false},
    {'time': '03:00 PM', 'enabled': true},
    {'time': '04:30 PM', 'enabled': true},
    {'time': '05:00 PM', 'enabled': true},
    {'time': '05:30 AM', 'enabled': true},
  ];
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
                color: isSelected == i ? kJuiceBarColor : Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: isSelected == i
                    ? Border.all(color: kJuiceBarColor)
                    : Border.all(color: Colors.white),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat.d().format(date),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.E().format(date).toUpperCase(),
                    style: const TextStyle(fontSize: 12),
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
              const ServiceCard(
                  imageUrl: "assets/images/splash_screen_image.png",
                  title: "Hair Cut",
                  price: "25",
                  description: "by Kenneth Allen"),
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
                  height: 3 *
                      30.0, // Adjust height based on your row height (60.0 is an example)
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
                                ? kPilatesLoftColor
                                : isEnabled
                                    ? Colors.white
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                            border: isSelected
                                ? Border.all(color: kPilatesLoftColor)
                                : isEnabled
                                    ? Border.all(color: Colors.white)
                                    : Border.all(color: Colors.grey[300]!),
                          ),
                          child: Text(
                            slot['time'],
                            style: TextStyle(
                              color: isEnabled ? Colors.black : Colors.grey,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 80),
                margin: const EdgeInsets.only(left: 50, top: 10, bottom: 10),
                child: CustomButton(
                  bgColor: const Color.fromARGB(255, 0, 10, 20),
                  borderRadius: 50.0,
                  bgIconColor: Colors.white,
                  bgTextColor: Colors.white,
                  title: "Book Slot",
                  icon: Icons.schedule_send_outlined,
                  vertical: 10.0,
                  horizontal: 5.0,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        Future.delayed(const Duration(seconds: 2), () {
                          Navigator.of(context).pop();
                          showAlert(context,
                              title: "Success",
                              message: "Appointment Successful!!!");
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const OrderFinalScreen()));
                        });
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
        title: "Juice Bar");
  }
}
