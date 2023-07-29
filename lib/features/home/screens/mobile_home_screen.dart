import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';

import '../../../constants/colors/custom_colors.dart';
import '../../../customWidgets/loader.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/destination_provider.dart';
import '../../explore_destination/screens/explore_destination_screen.dart';
import '../../explore_maps/screens/explore_maps_screen.dart';
import '../../itinerary/screens/itinerary_screen.dart';

class MobileHomeScreen extends StatefulWidget {
  const MobileHomeScreen({super.key});

  @override
  State<MobileHomeScreen> createState() => _MobileHomeScreenState();
}

class _MobileHomeScreenState extends State<MobileHomeScreen> {
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

  void fetchDestinationList() {
    context.read<DestinationProvider>().fetchDestinationList(context);
    context.read<DestinationProvider>().fetchSavedDestinationList(context);
  }

  int selectedIndex = 1;

  List<Widget> screens = [
    const ItineraryScreen(),
    const ExploreDestinationScreen(),
    const ExploreMapsScreen(),
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
              },
            ),
            ListTile(
              selected: selectedIndex == 2,
              title: const Text(
                'Saved Destinations',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: const Icon(
                Icons.my_location_rounded,
                color: Colors.white,
              ),
              onTap: () {
                setSelectedIndex(2);
              },
            ),
            ListTile(
              selected: selectedIndex == 2,
              title: const Text(
                'Saved Itineraries',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              trailing: const Icon(
                Icons.timeline_outlined,
                color: Colors.white,
              ),
              onTap: () {
                setSelectedIndex(2);
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
