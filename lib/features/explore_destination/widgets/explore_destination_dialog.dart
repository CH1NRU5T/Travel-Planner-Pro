import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/models/particular_destination_model.dart';
import 'package:travel_planner_pro/models/review_model.dart';
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
                    disableCenter: true,
                    viewportFraction: 0.3,
                  )),
            ),
            10.height,
            ListTile(
              leading: Text(
                destination.destination!.description,
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
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
                },
              ),
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
            10.height,
            TextButton.icon(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: const Text('Submit'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.add_rounded,
              ),
              label: const Text('Add Review'),
            ),
            10.height,
            destination.reviews.isEmpty
                ? const ListTile(
                    title: Text(
                      'No Reviews',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: destination.reviews.length,
                    itemBuilder: (context, index) {
                      Review review = destination.reviews[index];
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              review.reviewerName,
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            RatingBar.builder(
                              initialRating: review.rating,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {},
                            ),
                          ],
                        ),
                        subtitle: Text(
                          review.review,
                        ),
                        // Text(
                        //   destination.reviews[index].rating.toString(),
                        //   style: const TextStyle(
                        //       fontSize: 20, fontWeight: FontWeight.bold),
                        // ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
