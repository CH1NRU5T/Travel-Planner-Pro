import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/features/explore_destination/services/explore_destination_service.dart';
import 'package:travel_planner_pro/features/saved_destination/screens/saved_destination_screen.dart';

import '../../../constants/colors/custom_colors.dart';
import '../../../customWidgets/loader.dart';
import '../../../providers/auth_provider.dart';
import '../../explore_destination/screens/explore_destination_screen.dart';
import '../../explore_maps/screens/explore_maps_screen.dart';
import '../../itinerary_list/screens/itinerary_list_screen.dart';
import '../../saved_itinerary/screens/saved_itinerary_screen.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
  ExploreDestinationService exploreDestinationService =
      ExploreDestinationService();
  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDestinationList();
  }

  void fetchDestinationList() async {
    await exploreDestinationService.fetchDestinationList(context);
    if (context.mounted) {
      await exploreDestinationService.fetchSavedDestinationList(context);
    }
  }

  int selectedIndex = 0;

  List<Widget> screens = [
    const ItineraryListScreen(),
    const ExploreDestinationScreen(),
    const ExploreMapsScreen(),
    const SavedDestinationScreen(),
    const SavedItineraryScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: CustomColors.darkBlue,
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  const Expanded(
                      child: Loader(
                    loop: false,
                  )),
                  Expanded(
                    child: FittedBox(
                      child: Text(
                        'Travel Planner',
                        style: TextStyle(color: CustomColors.yellow),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              selected: selectedIndex == 0,
              title: const Text(
                'Itinerary',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: const Icon(
                Icons.notes_outlined,
                color: Colors.white,
              ),
              onTap: () {
                setSelectedIndex(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 1,
              title: const Text(
                'Explore Destination',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: const Icon(
                Icons.location_on_rounded,
                color: Colors.white,
              ),
              onTap: () {
                setSelectedIndex(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 2,
              title: const Text(
                'Explore Maps',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: const Icon(
                Icons.map_outlined,
                color: Colors.white,
              ),
              onTap: () {
                setSelectedIndex(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 3,
              title: const Text(
                'Saved Destinations',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: const Icon(
                Icons.my_location_rounded,
                color: Colors.white,
              ),
              onTap: () {
                setSelectedIndex(3);
                Navigator.pop(context);
              },
            ),
            ListTile(
              selected: selectedIndex == 4,
              title: const Text(
                'Saved Itineraries',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: const Icon(
                Icons.timeline_outlined,
                color: Colors.white,
              ),
              onTap: () {
                setSelectedIndex(4);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Icon(Icons.flight_takeoff_rounded),
        actions: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Material(
              child: PopupMenuButton(
                tooltip: '',
                child: const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/user.jpg'),
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      onTap: () {
                        context.read<AuthProvider>().clearUser(context);
                      },
                      child: const Text(
                        ('Logout'),
                      ),
                    ),
                  ];
                },
              ),
            ),
          ),
          20.width,
        ],
      ),
      body: screens[selectedIndex],
    );
  }
}
