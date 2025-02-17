import 'package:flutter/material.dart';
import 'package:ten20/components/custom_button.dart';
import 'package:ten20/components/custom_layout_inner.dart';
import 'package:ten20/screens/home/juice_bar/pages/order_final_screen.dart';
import 'package:ten20/utils/constants.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

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
                  const Text('Select Payment Method ', style: contentHeader)
                ],
              ),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Ten20 Wallet",
                            style: contentHeader,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Credit / Debit card",
                                style: contentHeader,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.arrow_drop_down_sharp,
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                        // const SizedBox(height: 15),
                        // Container(
                        //     color: const Color.fromARGB(26, 0, 0, 0),
                        //     width: MediaQuery.of(context).size.width - 70,
                        //     height: 2),
                        // const SizedBox(height: 15),
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Net Banking",
                            style: contentHeader,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(
                            "Other Methods",
                            style: contentHeader,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.arrow_drop_down_sharp,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )),
              const Spacer(),
              Container(
                padding: const EdgeInsets.fromLTRB(40, 0, 0, 80),
                margin: const EdgeInsets.only(left: 50, top: 10, bottom: 10),
                child: CustomButton(
                  bgColor: const Color.fromARGB(255, 0, 10, 20),
                  borderRadius: 50.0,
                  bgIconColor: Colors.white,
                  bgTextColor: Colors.white,
                  title: "Pay QAR 100",
                  icon: Icons.schedule_send_outlined,
                  vertical: 10.0,
                  horizontal: 5.0,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OrderFinalScreen()));
                  },
                ),
              )
            ],
          ),
        ),
        title: 'Juice Bar');
  }
}
