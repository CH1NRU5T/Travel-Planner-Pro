import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/models/particular_destination_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ExploreDestinationDialog extends StatelessWidget {
  const ExploreDestinationDialog({super.key, required this.destination});
  final ParticularDestination destination;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: MediaQuery.sizeOf(context).height * 0.8,
        padding: const EdgeInsets.all(12),
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  destination.destination!.destinationName,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 25),
                ),
                Row(
                  children: [
                    Text(
                      '${destination.currentTemperature}°C',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    10.width,
                    Image.network(destination.weatherIcon),
                    10.width,
                    Text(
                      destination.currentWeather,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ],
                ),
              ],
            ),
            10.height,
            SizedBox(
              height: 200,
              child: CarouselSlider.builder(
                  itemCount: destination.destination!.images.length,
                  itemBuilder: (context, index, realIndex) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: Image.network(
                        destination.destination!.images[index],
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enableInfiniteScroll: true,
                    // enlargeCenterPage: true,
                    disableCenter: true,
                    viewportFraction: 0.3,
                  )),
            ),
            10.height,
            ListTile(
              leading: Text(
                destination.destination!.cityName,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              trailing: TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  label: const Text('Directions'),
                  icon: const Icon(Icons.directions_outlined),
                  onPressed: () async {
                    await launchUrl(
                        Uri.parse(
                            'https://maps.google.com/maps?q=${destination.destination!.latitude},${destination.destination!.longitude}'),
                        mode: LaunchMode.externalApplication);
                  }),
            ),
            10.height,
            ListTile(
              leading: Text(
                destination.destination!.avgTravelExpenses,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                destination.destination!.category,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            // Row(children: [
            //   Expanded(child: ,),
            //   // Expanded(),
            // ],)
          ],
        ),
      ),
    );
  }
}
