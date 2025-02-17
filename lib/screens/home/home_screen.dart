import 'package:flutter/material.dart';
import 'package:ten20/components/custom_app_bar.dart';
import 'package:ten20/components/custom_drawer.dart';
import 'package:ten20/screens/home/hair_bar/hair_bar_home.dart';
import 'package:ten20/screens/home/juice_bar/juice_bar_home.dart';
import 'package:ten20/screens/home/nails_diner/nails_diner_home.dart';
import 'package:ten20/screens/home/pilates_loft/pilates_loft_home.dart';
import 'package:ten20/utils/api_service.dart';
import 'package:ten20/utils/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService apiService = ApiService();
  dynamic services = [];

  @override
  void initState() {
    super.initState();
    getServices();
  }

  void getServices() async {
    try {
      var result = await apiService.get_main_services();
      print(result.length);
      if (result != 0) {
        loadUserId();
        setState(() {
          services = result;
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBgColor,
      appBar: CustomAppBar(isTitleEnabled: false, title: ""),
      drawer: const CustomDrawer(), // Attach the CustomDrawer here
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 12, bottom: 100),
              child: Text("Hello, Sam",
                  style: TextStyle(color: Colors.black, fontSize: 20)),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 1,
                ),
                itemCount: services.length, // Number of items in the grid
                itemBuilder: (context, index) {
                  var service = services[index];
                  // Set up properties based on service data
                  String title = (service['name'] == "Nails Diner"
                      ? "Nails\n Diner"
                      : service['name'] == "Hair Bar"
                          ? "Hair\n Bar"
                          : service['name'] == "Pilates Loft"
                              ? "Pilates\n Loft"
                              : "Juice Bar");
                  String image = (service['name'] == "Nails Diner"
                      ? "assets/icons/nails_diner.png"
                      : service['name'] == "Hair Bar"
                          ? "assets/icons/hair_bar.png"
                          : service['name'] == "Pilates Loft"
                              ? "assets/icons/pilates_loft.png"
                              : "assets/icons/juice_bar.png");
                  Color color = (service['name'] == "Nails Diner"
                      ? kNailsDinerColor
                      : service['name'] == "Hair Bar"
                          ? kHairBarColor
                          : service['name'] == "Pilates Loft"
                              ? kPilatesLoftColor
                              : kJuiceBarColor);
                  Widget destinationPage = (service['name'] == "Nails Diner"
                      ? NailsDinerPage(
                          id: service['id'] != null &&
                                  service['id'] is String &&
                                  service['id'].isNotEmpty
                              ? int.tryParse(service['id']) ?? 0
                              : service['id'] as int? ?? 0)
                      : service['name'] == "Hair Bar"
                          ? HairBarPage(
                              id: service['id'] != null &&
                                      service['id'] is String &&
                                      service['id'].isNotEmpty
                                  ? int.tryParse(service['id']) ?? 0
                                  : service['id'] as int? ?? 0)
                          : service['name'] == "Pilates Loft"
                              ? PilatesLoftPage(
                                  id: service['id'] != null &&
                                          service['id'] is String &&
                                          service['id'].isNotEmpty
                                      ? int.tryParse(service['id']) ?? 0
                                      : service['id'] as int? ?? 0)
                              : JuiceBarPage(
                                  id: service['id'] != null &&
                                          service['id'] is String &&
                                          service['id'].isNotEmpty
                                      ? int.tryParse(service['id']) ?? 0
                                      : service['id'] as int? ?? 0));
                  return _buildHeartContainer(
                    title: title,
                    image: image,
                    color: color,
                    context: context,
                    destinationPage: destinationPage,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeartContainer({
    required String title,
    required Color color, // This color is no longer used in the image version
    required String image,
    required BuildContext context,
    required Widget destinationPage,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height:
            250, // Ensure the container height fits well with the heart image
        child: Stack(
          alignment: Alignment.center, // Center the content
          children: [
            // Replace the CustomPaint with an Image widget for the heart background
            Image.asset(
              image, // Replace with the path to your heart image
              fit: BoxFit.cover, // Adjust the image fit as needed
            ),
            // Center the text within the container
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
