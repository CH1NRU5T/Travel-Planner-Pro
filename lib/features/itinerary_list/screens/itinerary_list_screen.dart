import 'package:flutter/material.dart';
import 'package:travel_planner_pro/customWidgets/responsive_widget.dart';
import 'package:travel_planner_pro/features/itinerary_list/screens/mobile_itinerary_list_screen.dart';
import 'package:travel_planner_pro/features/itinerary_list/screens/web_itinerary_list_screen.dart';

class ItineraryListScreen extends StatelessWidget {
  const ItineraryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
        mobile: MobileItineraryListScreen(), web: WebItineraryListScreen());
  }
}
