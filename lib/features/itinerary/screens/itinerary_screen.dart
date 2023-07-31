import 'package:flutter/material.dart';
import 'package:travel_planner_pro/customWidgets/responsive_widget.dart';
import 'package:travel_planner_pro/features/itinerary/screens/mobile_itinerary_screen.dart';
import 'package:travel_planner_pro/features/itinerary/screens/web_itinerary_screen.dart';

// class ItineraryScreen1 extends StatefulWidget {
//   const ItineraryScreen({super.key, required this.itid});
//   static const routeName = '/itinerary';
//   final String itid;
//   @override
//   State<ItineraryScreen> createState() => _ItineraryScreenState();
// }

// class _ItineraryScreenState extends State<ItineraryScreen> {
//   ItineraryService itineraryService = ItineraryService();
//   Itinerary? itinerary;
//   @override
//   void initState() {
//     super.initState();
//     getItinerary();
//   }

//   void getItinerary() async {
//     (String?, Itinerary?) record =
//         await itineraryService.getItinerary(context, widget.itid);
//     if (record.$1 == null) {
//       setState(() {
//         itinerary = record.$2;
//       });
//     } else {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(record.$1!)));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveWidget(mobile: MobileItineraryScreen(itid: ,), web: web)
//   }
// }

class ItineraryScreen extends StatelessWidget {
  final String itid;
  static const routeName = '/itinerary';
  const ItineraryScreen({super.key, required this.itid});

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      mobile: MobileItineraryScreen(itid: itid),
      web: WebItineraryScreen(itid: itid),
    );
  }
}
