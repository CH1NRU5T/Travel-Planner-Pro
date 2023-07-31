import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/customWidgets/loader.dart';
import 'package:travel_planner_pro/features/empty/screens/empty_screen.dart';
import 'package:travel_planner_pro/features/itinerary_list/widgets/itinerary_list_card.dart';
import 'package:travel_planner_pro/providers/itinerary_provider.dart';

import '../../../models/itinerary_model.dart';
import '../services/itinerary_list_service.dart';

class WebItineraryListScreen extends StatefulWidget {
  const WebItineraryListScreen({super.key});

  @override
  State<WebItineraryListScreen> createState() => _WebItineraryListScreenState();
}

class _WebItineraryListScreenState extends State<WebItineraryListScreen> {
  late ItineraryListService itineraryService;
  late ItineraryProvider provider;
  @override
  void initState() {
    super.initState();
    itineraryService = ItineraryListService();
    fetch();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    provider = context.watch<ItineraryProvider>();
  }

  void fetch() async {
    (String?, List<Itinerary>?) record =
        await itineraryService.fetchItineraryList(context);

    if (record.$1 != null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(record.$1!)));
      }
    } else {
      if (context.mounted) {
        context.read<ItineraryProvider>().setItineraryList(record.$2!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ItineraryProvider>(
      builder: (context, value, child) {
        return value.itineraryList == null
            ? const Center(
                child: Loader(),
              )
            : value.itineraryList!.isEmpty
                ? const EmptyScreen()
                : Padding(
                    padding: const EdgeInsets.all(12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      child: Wrap(
                        runSpacing: 10,
                        children: value.itineraryList!.map((e) {
                          return ItineraryListCard(
                            fav: e.fav,
                            wf: 0.25,
                            hf: 0.5,
                            travelMode: e.travelMode,
                            id: e.id,
                            details: e.items,
                            planName: e.planName,
                            destination: e.destination,
                            startDate: e.travelStartDate,
                            endDate: e.travelEndDate,
                            cost: e.estimatedCost,
                          );
                        }).toList(),
                      ),
                    ),
                  );
      },
    );
  }
}
