import 'package:flutter/material.dart';

import '../../../constants/colors/custom_colors.dart';
import '../../explore_destination/screens/explore_destination_screen.dart';
import '../../explore_maps/screens/explore_maps_screen.dart';
import '../../itinerary/screens/itinerary_screen.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> screens = [
    const ItineraryScreen(),
    const ExploreDestinationScreen(),
    const ExploreMapsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: ListView(
              children: [
                DrawerHeader(
                  child: FittedBox(
                    child: Text(
                      'Travel Planner',
                      style: TextStyle(color: CustomColors.yellow),
                    ),
                  ),
                ),
                ListTile(
                  tileColor: selectedIndex == 0 ? Colors.grey.shade300 : null,
                  title: const Text('Itinerary'),
                  trailing: const Icon(Icons.notes_outlined),
                  onTap: () {
                    setSelectedIndex(0);
                  },
                ),
                ListTile(
                  tileColor: selectedIndex == 1 ? Colors.grey.shade300 : null,
                  title: const Text('Explore Destination'),
                  trailing: const Icon(Icons.location_on_rounded),
                  onTap: () {
                    setSelectedIndex(1);
                  },
                ),
                ListTile(
                  tileColor: selectedIndex == 2 ? Colors.grey.shade300 : null,
                  title: const Text('Explore Maps'),
                  trailing: const Icon(Icons.map_outlined),
                  onTap: () {
                    setSelectedIndex(2);
                  },
                ),
              ],
            ),
          ),
          Expanded(flex: 4, child: screens[selectedIndex]),
        ],
      ),
    );
  }
}
