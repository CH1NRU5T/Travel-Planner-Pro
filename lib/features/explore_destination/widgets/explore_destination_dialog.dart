import 'package:flutter/material.dart';
import 'package:travel_planner_pro/models/particular_destination_model.dart';

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
          children: [
            Text(
              destination.currentTemperature.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
