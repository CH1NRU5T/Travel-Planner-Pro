import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/models/itinerary_model.dart';

class ItineraryDialog extends StatelessWidget {
  const ItineraryDialog(
      {super.key,
      required this.dateAndDetail,
      required this.planName,
      required this.destination,
      required this.startDate,
      required this.endDate,
      required this.cost,
      required this.travelMode,
      required this.id});
  final List<DateAndDetail> dateAndDetail;
  final String id;
  final String planName;
  final String destination;
  final DateTime startDate;
  final DateTime endDate;
  final int cost;
  final String travelMode;
  //TODO: Change this to the actual link
  final String shareBaseLink = 'http://localhost:62671/';
  @override
  Widget build(BuildContext context) {
    int length = dateAndDetail.length;
    return AlertDialog(
        scrollable: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(planName, style: Theme.of(context).textTheme.headlineLarge),
            const Divider(),
            Text(destination, style: Theme.of(context).textTheme.titleLarge),
            5.height,
            Text(
                '${DateFormat('dd MMM yyyy').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}',
                style: Theme.of(context).textTheme.titleLarge),
            5.height,
            Text(travelMode, style: Theme.of(context).textTheme.titleLarge),
            5.height,
            Text('₹ $cost', style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width * 0.15,
          height: MediaQuery.of(context).size.height * 0.3,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < length; i++)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Divider(),
                          Text(
                            '${i + 1}. ${dateAndDetail[i].dayDetail}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          const Expanded(
                              child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 5),
                            child: Divider(),
                          )),
                          Text(
                            DateFormat('d MMM yyyy')
                                .format(dateAndDetail[i].date),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                  ],
                ),
                TextButton.icon(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(
                        text: '$shareBaseLink#/itinerary?itid=$id'));
                    if (context.mounted) {
                      context.showToast(msg: 'Link Copied to ClipBoard!');
                    }
                  },
                  icon: const Icon(
                    Icons.share_rounded,
                  ),
                  label: const Text('Share'),
                ),
              ]),
        ));
  }
}
