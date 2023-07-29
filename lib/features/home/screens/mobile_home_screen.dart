import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';

import '../../../constants/colors/custom_colors.dart';
import '../../../providers/auth_provider.dart';
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

  int selectedIndex = 0;

  List<Widget> screens = [
    const ItineraryScreen(),
    const ExploreDestinationScreen(),
    const ExploreMapsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: selectedIndex == 1 ? Colors.grey.shade300 : null,
              title: const Text('Explore Destination'),
              trailing: const Icon(Icons.location_on_rounded),
              onTap: () {
                setSelectedIndex(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              tileColor: selectedIndex == 2 ? Colors.grey.shade300 : null,
              title: const Text('Explore Maps'),
              trailing: const Icon(Icons.map_outlined),
              onTap: () {
                setSelectedIndex(2);
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
                        context.read<AuthProvider>().clearUser();
                        Navigator.pop(context);
                        // Navigator.pushNamedAndRemoveUntil(
                        //   context,
                        //   LandingScreen.routeName,
                        //   (_) => true,
                        // );
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
