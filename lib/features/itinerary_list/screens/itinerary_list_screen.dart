import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/customWidgets/loader.dart';
import 'package:travel_planner_pro/features/itinerary_list/widgets/itinerary_list_card.dart';
import 'package:travel_planner_pro/providers/itinerary_provider.dart';

import '../../../models/itinerary_model.dart';
import '../services/itinerary_list_service.dart';

class ItineraryListScreen extends StatefulWidget {
  const ItineraryListScreen({super.key});

  @override
  State<ItineraryListScreen> createState() => _ItineraryListScreenState();
}

class _ItineraryListScreenState extends State<ItineraryListScreen> {
  ItineraryListService itineraryService = ItineraryListService();
  late ItineraryProvider provider;
  @override
  void initState() {
    super.initState();
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
            : Padding(
                padding: const EdgeInsets.all(12),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    spacing: 10,
                    children: value.itineraryList!.map((e) {
                      return ItineraryListCard(
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
