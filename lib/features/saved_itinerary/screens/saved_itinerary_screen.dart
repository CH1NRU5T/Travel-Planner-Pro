import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/features/empty/screens/empty_screen.dart';
import 'package:travel_planner_pro/features/saved_itinerary/services/saved_itinerary_service.dart';

import '../../../customWidgets/loader.dart';
import '../../../providers/itinerary_provider.dart';
import '../../itinerary_list/widgets/itinerary_list_card.dart';

class SavedItineraryScreen extends StatefulWidget {
  const SavedItineraryScreen({super.key});

  @override
  State<SavedItineraryScreen> createState() => _SavedItineraryScreenState();
}

class _SavedItineraryScreenState extends State<SavedItineraryScreen> {
  SavedItineraryService savedItineraryService = SavedItineraryService();

  @override
  void initState() {
    super.initState();
    savedItineraryService.getSavedItineraryList(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItineraryProvider>(
      builder: (context, value, child) {
        return value.savedItineraryList == null
            ? const Center(
                child: Loader(),
              )
            : value.savedItineraryList!.isEmpty
                ? const EmptyScreen()
                : Padding(
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Wrap(
                        verticalDirection: VerticalDirection.down,
                        runSpacing: 10,
                        children: value.savedItineraryList!.map(
                          (e) {
                            return ItineraryListCard(
                              fav: true,
                              wf: 1,
                              hf: 0.4,
                              travelMode: e.travelMode,
                              id: e.id,
                              details: e.items,
                              planName: e.planName,
                              destination: e.destination,
                              startDate: e.travelStartDate,
                              endDate: e.travelEndDate,
                              cost: e.estimatedCost,
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  );
      },
    );
  }
}
