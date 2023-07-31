import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../models/particular_destination_model.dart';
import '../../../../models/review_model.dart';
import '../../services/explore_destination_service.dart';

class MobileExploreDestinationDialog extends StatefulWidget {
  const MobileExploreDestinationDialog({super.key, required this.destination});
  final ParticularDestination destination;

  @override
  State<MobileExploreDestinationDialog> createState() =>
      _MobileExploreDestinationDialogState();
}

class _MobileExploreDestinationDialogState
    extends State<MobileExploreDestinationDialog> {
  late List<Review> reviews;
  @override
  void initState() {
    super.initState();
    reviews = widget.destination.reviews;
  }

  ExploreDestinationService service = ExploreDestinationService();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.destination.destination!.destinationName,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 30),
      ),
      content: Container(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: MediaQuery.sizeOf(context).height * 0.8,
        padding: const EdgeInsets.all(12),
        child: ListView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${widget.destination.currentTemperature}°C',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                10.width,
                Expanded(
                    child: Image.network(
                  widget.destination.weatherIcon,
                  scale: 1.5,
                )),
                10.width,
                Expanded(
                  child: Text(
                    widget.destination.currentWeather,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ],
            ),
            10.height,
            SizedBox(
              child: CarouselSlider.builder(
                itemCount: widget.destination.destination!.images.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    child: Image.network(
                      widget.destination.destination!.images[index],
                      fit: BoxFit.cover,
                    ),
                  );
                },
                options: CarouselOptions(
                  enlargeCenterPage: true,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  disableCenter: true,
                  viewportFraction: 0.8,
                ),
              ),
            ),
            10.height,
            Text(
              widget.destination.destination!.description,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
            ),
            10.height,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.destination.destination!.cityName,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 20),
                ),
                IconButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.directions_outlined),
                  onPressed: () async {
                    await launchUrl(
                        Uri.parse(
                            'https://maps.google.com/maps?q=${widget.destination.destination!.latitude},${widget.destination.destination!.longitude}'),
                        mode: LaunchMode.externalApplication);
                  },
                ),
              ],
            ),
            10.height,
            Text(
              widget.destination.destination!.avgTravelExpenses,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 15),
            ),
            Text(
              widget.destination.destination!.category,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontSize: 15),
            ),
            10.height,
            TextButton.icon(
              onPressed: () async {
                TextEditingController reviewController =
                    TextEditingController();
                int inputRating = 0;
                await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: const Text('Add Review'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () async {
                              (String, bool) response = await service.addReview(
                                  review: reviewController.text,
                                  rating: inputRating,
                                  destination_id:
                                      widget.destination.destination!.id);
                              if (context.mounted) {
                                context.showToast(msg: response.$1);
                                if (response.$2) {
                                  reviews.insert(
                                      0,
                                      Review(
                                        destination_id:
                                            widget.destination.destination!.id,
                                        reviewerName: 'You',
                                        rating: inputRating.toDouble(),
                                        review: reviewController.text,
                                        date: DateTime.now(),
                                      ));
                                }
                                setState(() {});
                                Navigator.pop(context);
                              }
                            },
                            child: const Text('Submit'),
                          ),
                        ],
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextFormField(
                              controller: reviewController,
                              decoration: const InputDecoration(
                                labelText: 'Review',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            10.height,
                            RatingBar.builder(
                              initialRating: 0,
                              minRating: 0,
                              direction: Axis.horizontal,
                              allowHalfRating: false,
                              itemCount: 5,
                              itemSize: 20,
                              itemPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                setState(() {
                                  inputRating = rating.toInt();
                                });
                              },
                            ),
                          ],
                        ));
                  },
                );
              },
              icon: const Icon(
                Icons.add_rounded,
              ),
              label: const Text('Add Review'),
            ),
            10.height,
            widget.destination.reviews.isEmpty
                ? const ListTile(
                    title: Text(
                      'No Reviews',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: widget.destination.reviews.length,
                    itemBuilder: (context, index) {
                      Review review = widget.destination.reviews[index];
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
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
