import 'package:flutter/material.dart';
import 'package:ten20/components/custom_button.dart';
import 'package:ten20/components/custom_layout_inner.dart';
import 'package:ten20/screens/home/juice_bar/pages/payment_scree.dart';

class DrinkDetailsScreen extends StatelessWidget {
  const DrinkDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomLayout(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(12, 5, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Smoothie',
                          style: TextStyle(fontFamily: 'CeraPro'))),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  const Text('Fruit Smoothie',
                      style: TextStyle(fontFamily: 'CeraPro'))
                ],
              ),
              const SizedBox(height: 10),
              Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  height: 200,
                  width: MediaQuery.of(context).size.width - 20,
                  child: Image.asset("assets/images/drink/15.png")),
              const SizedBox(height: 10),
              const Text('Fruit Smoothie',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
              const Text(
                  'Description of the product can be provided here in detailed. This product is lorem ipsum.',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 0, 10, 20))),
              const SizedBox(height: 10),
              const Text('QAR 100',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 34, 34, 34))),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 100, 30, 0),
                child: CustomButton(
                  bgColor: const Color.fromARGB(255, 0, 10, 20),
                  borderRadius: 50.0,
                  bgIconColor: Color.fromARGB(255, 255, 255, 255),
                  bgTextColor: Colors.white,
                  title: "Add to Cart ",
                  icon: Icons.shopping_bag,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const PaymentScreen()));
                  },
                ),
              )
            ],
          ),
        ),
        title: 'Juice Bar');
  }
}
