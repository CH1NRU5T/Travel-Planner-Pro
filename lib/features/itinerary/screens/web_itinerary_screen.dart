import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/customWidgets/loader.dart';
import 'package:travel_planner_pro/features/itinerary/services/itinerary_service.dart';
import 'package:travel_planner_pro/models/itinerary_model.dart';

class WebItineraryScreen extends StatefulWidget {
  const WebItineraryScreen({super.key, required this.itid});

  final String itid;
  @override
  State<WebItineraryScreen> createState() => _WebItineraryScreenState();
}

class _WebItineraryScreenState extends State<WebItineraryScreen> {
  ItineraryService itineraryService = ItineraryService();
  Itinerary? itinerary;
  @override
  void initState() {
    super.initState();
    getItinerary();
  }

  void getItinerary() async {
    (String?, Itinerary?) record =
        await itineraryService.getItinerary(context, widget.itid);
    if (record.$1 == null) {
      setState(() {
        itinerary = record.$2;
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(record.$1!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: itinerary == null
            ? const Loader()
            : Card(
                child: SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(itinerary!.planName,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            const Divider(),
                            Text(itinerary!.destination,
                                style: const TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            5.height,
                            Text(
                                '${DateFormat('dd MMM yyyy').format(itinerary!.travelStartDate)} - ${DateFormat('dd MMM yyyy').format(itinerary!.travelEndDate)}',
                                style: Theme.of(context).textTheme.titleLarge),
                            5.height,
                            Text('Travel mode: ${itinerary!.travelMode}',
                                style: Theme.of(context).textTheme.titleLarge),
                            5.height,
                            Text('Cost: ₹ ${itinerary!.estimatedCost}',
                                style: Theme.of(context).textTheme.titleLarge),
                            10.height,
                            Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      for (int i = 0;
                                          i < itinerary!.items.length;
                                          i++)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Divider(),
                                            Text(
                                              '${i + 1}. ${itinerary!.items[i].dayDetail}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                            const Expanded(
                                                child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 5),
                                              child: Divider(),
                                            )),
                                            Text(
                                              DateFormat('d MMM yyyy').format(
                                                  itinerary!.items[i].date),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
