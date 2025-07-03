// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:ten20/components/custom_layout_inner.dart';
// import 'package:ten20/components/service_card.dart';
import 'package:ten20/model/service_item.dart';
import 'package:ten20/screens/home/pilates_loft/pages/order_final_screen.dart';
import 'package:ten20/screens/wallet/wallet.dart';
// import 'package:ten20/screens/home/pilates_loft/pages/assistant_screen.dart';
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

  void _showInstructorProfile(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFF5F5F5),
                  Color(0xFFE8E8E8),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: Color(0xFFB7B89F),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                // Profile image
                Container(
                  width: 120,
                  height: 160,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: DecorationImage(
                      image: NetworkImage(
                        services[0].imageUrl, // Replace with actual image URL
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Name
                const Text(
                  'Paria Sadat',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6B799A),
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                const Text(
                  'Pilates Instructor',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF6B799A),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '"Welcome to our boutique Pilates studio – a calm, empowering space where movement meets mindfulness. Personalized sessions, expert guidance, and a focus on strength from within."',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[700],
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Bottom indicator dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 8,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }

  void showPaymentMethodPopup(BuildContext context, String price) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFB7B89F),
                Color(0xFFA8A98A),
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle bar
                Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 20),
                // Header
                const Column(
                  children: [
                    Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'TEN 20 Pilates',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Payment options
                Row(
                  children: [
                    // Wallet option
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle wallet payment
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const WalletScreen(),
                            ),
                          );
                          // Add your wallet payment logic here
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'Wallet',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B799A),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    // Add Funds option
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle add funds
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const WalletScreen(),
                            ),
                          );
                          // Add your add funds logic here
                        },
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Center(
                            child: Text(
                              'Add Funds',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6B799A),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                // Book Slot Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    onPressed: () {
                      // Handle book slot
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const OrderFinalScreen(),
                        ),
                      );
                      // Add your booking logic here
                    },
                    child: Text(
                      'Book Slot - $price QR',
                      style: const TextStyle(
                        color: Color(0xFF6B799A),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
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
                                  onPressed: () {
                                    _showInstructorProfile(context);
                                  },
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
                                showPaymentMethodPopup(
                                    context, services[0].price);
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
                          const SizedBox(height: 70),
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
