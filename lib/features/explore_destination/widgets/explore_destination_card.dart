import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/customWidgets/loader.dart';
import 'package:travel_planner_pro/features/explore_destination/services/explore_destination_service.dart';
import 'package:travel_planner_pro/features/explore_destination/widgets/explore_destination_dialog.dart';
import 'package:travel_planner_pro/models/particular_destination_model.dart';
import 'package:travel_planner_pro/providers/destination_provider.dart';

import '../../../models/destination_model.dart';

class ExploreDestinationCard extends StatelessWidget {
  ExploreDestinationCard({super.key, required this.destination});
  final ExploreDestinationService exploreDestinationService =
      ExploreDestinationService();
  final Destination destination;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return const Loader();
                },
              );
              (String?, ParticularDestination?) record =
                  await exploreDestinationService.fetchParticularDestination(
                      context,
                      destination.id,
                      context
                          .read<DestinationProvider>()
                          .particularDestinationList);
              if (context.mounted) {
                Navigator.pop(context);
                if (record.$1 == null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return ExploreDestinationDialog(
                        destination: record.$2!,
                      );
                    },
                  );
                } else {
                  context.showToast(msg: record.$1!);
                }
              }
            },
            child: Container(
              height: 200,
              width: 250,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(destination.images.first),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          10.height,
          FittedBox(
            child: Text(
              destination.destinationName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          10.height,
          FittedBox(
            child: Text(
              destination.avgTravelExpenses,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
