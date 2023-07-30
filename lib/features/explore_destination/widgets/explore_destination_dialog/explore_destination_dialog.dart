import 'package:flutter/material.dart';
import 'package:travel_planner_pro/customWidgets/responsive_widget.dart';
import 'package:travel_planner_pro/features/explore_destination/widgets/explore_destination_dialog/mobile_explore_destination_dialog.dart';
import 'package:travel_planner_pro/features/explore_destination/widgets/explore_destination_dialog/web_explore_destination_dialog.dart';
import 'package:travel_planner_pro/models/particular_destination_model.dart';

class ExploreDestinationDialog extends StatelessWidget {
  const ExploreDestinationDialog({super.key, required this.destination});
  final ParticularDestination destination;

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        mobile: MobileExploreDestinationDialog(
          destination: destination,
        ),
        web: WebExploreDestinationDialog(destination: destination));
  }
}
