import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_planner_pro/features/itinerary_list/widgets/itinerary_dialog.dart';
import 'package:travel_planner_pro/models/itinerary_model.dart';

class ItineraryListCard extends StatelessWidget {
  final double wf, hf;
  const ItineraryListCard(
      {super.key,
      required this.planName,
      required this.destination,
      required this.startDate,
      required this.endDate,
      required this.cost,
      required this.details,
      required this.travelMode,
      required this.id,
      required this.wf,
      required this.hf});
  final String planName;
  final String id;
  final String destination;
  final String travelMode;
  final DateTime startDate;
  final DateTime endDate;
  final int cost;
  final List<DateAndDetail> details;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ItineraryDialog(
              id: id,
              travelMode: travelMode,
              planName: planName,
              destination: destination,
              startDate: startDate,
              endDate: endDate,
              cost: cost,
              dateAndDetail: details,
            );
          },
        );
      },
      child: Card(
        color: Colors.grey[300],
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * wf,
          height: MediaQuery.sizeOf(context).height * hf,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(planName,
                    style: Theme.of(context).textTheme.headlineLarge),
                const Divider(),
                Text(destination,
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                    '${DateFormat('dd MMM yyyy').format(startDate)} - ${DateFormat('dd MMM yyyy').format(endDate)}',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(travelMode, style: Theme.of(context).textTheme.titleLarge),
                Text('₹ $cost', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
