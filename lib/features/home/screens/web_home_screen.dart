import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/features/home/widgets/add_itinerary_dialog.dart';
import 'package:travel_planner_pro/features/itinerary_list/screens/itinerary_list_screen.dart';
import 'package:travel_planner_pro/features/saved_destination/screens/saved_destination_screen.dart';
import 'package:travel_planner_pro/features/saved_itinerary/screens/saved_itinerary_screen.dart';
import 'package:travel_planner_pro/providers/auth_provider.dart';

import '../../../constants/colors/custom_colors.dart';
import '../../../models/destination_model.dart';
import '../../../providers/destination_provider.dart';
import '../../explore_destination/screens/explore_destination_screen.dart';
import '../../explore_destination/services/explore_destination_service.dart';
import '../../explore_maps/screens/explore_maps_screen.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  late DestinationProvider destinationProvider;
  ExploreDestinationService exploreDestinationService =
      ExploreDestinationService();
  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    destinationProvider = context.watch<DestinationProvider>();
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
      if (context.mounted) {
        await exploreDestinationService.getKeywords(context);
      }
    }
    for (Destination saved in destinationProvider.savedDestinationList!) {
      for (Destination d in destinationProvider.destinationList!) {
        if (saved.id == d.id) {
          d.isSaved = true;
          break;
        }
      }
    }
  }

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
      floatingActionButton: selectedIndex == 0
          ? FloatingActionButton(
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) {
                    return const AddItineraryDialog();
                  },
                );
              },
              child: const Icon(Icons.add),
            )
          : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              child: Material(
                color: const Color.fromARGB(255, 5, 53, 92),
                child: Column(
                  children: [
                    DrawerHeader(
                      child: Column(
                        children: [
                          Expanded(
                              child: Lottie.asset(
                                  'assets/lottie/lottieAnimation.zip',
                                  repeat: false)),
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
                      selectedTileColor: CustomColors.darkerBlue,
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
                      selectedTileColor: CustomColors.darkerBlue,
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
                      selectedTileColor: CustomColors.darkerBlue,
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
                      selected: selectedIndex == 3,
                      selectedTileColor: CustomColors.darkerBlue,
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
                      },
                    ),
                    ListTile(
                      selected: selectedIndex == 4,
                      selectedTileColor: CustomColors.darkerBlue,
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
                      },
                    ),
                    const Expanded(child: SizedBox()),
                    ListTile(
                      hoverColor: Colors.red,
                      title: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      trailing: const Icon(
                        Icons.logout_rounded,
                        color: Colors.white,
                      ),
                      onTap: () {
                        context.read<AuthProvider>().clearUser(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(flex: 4, child: screens[selectedIndex]),
        ],
      ),
    );
  }
}
