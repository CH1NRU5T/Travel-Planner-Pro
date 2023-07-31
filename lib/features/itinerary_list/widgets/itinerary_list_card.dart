import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travel_planner_pro/features/itinerary_list/widgets/itinerary_dialog.dart';
import 'package:travel_planner_pro/features/saved_itinerary/services/saved_itinerary_service.dart';
import 'package:travel_planner_pro/models/itinerary_model.dart';

class ItineraryListCard extends StatefulWidget {
  final double wf, hf;
  final bool fav;
  const ItineraryListCard(
      {super.key,
      required this.planName,
      required this.fav,
      required this.destination,
      required this.startDate,
      required this.endDate,
      required this.cost,
      required this.details,
      required this.travelMode,
      required this.id,
      required this.wf,
      required this.hf});
  final String planName;
  final String id;
  final String destination;
  final String travelMode;
  final DateTime startDate;
  final DateTime endDate;
  final int cost;
  final List<DateAndDetail> details;

  @override
  State<ItineraryListCard> createState() => _ItineraryListCardState();
}

class _ItineraryListCardState extends State<ItineraryListCard> {
  SavedItineraryService savedItineraryService = SavedItineraryService();
  late bool fav;
  @override
  void initState() {
    super.initState();
    fav = widget.fav;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ItineraryDialog(
              id: widget.id,
              travelMode: widget.travelMode,
              planName: widget.planName,
              destination: widget.destination,
              startDate: widget.startDate,
              endDate: widget.endDate,
              cost: widget.cost,
              dateAndDetail: widget.details,
            );
          },
        );
      },
      child: Card(
        color: Colors.grey[300],
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * widget.wf,
          height: MediaQuery.sizeOf(context).height * widget.hf,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.planName,
                    style: Theme.of(context).textTheme.headlineLarge),
                const Divider(),
                Text(widget.destination,
                    style: Theme.of(context).textTheme.titleLarge),
                Text(
                    '${DateFormat('dd MMM yyyy').format(widget.startDate)} - ${DateFormat('dd MMM yyyy').format(widget.endDate)}',
                    style: Theme.of(context).textTheme.titleLarge),
                Text(widget.travelMode,
                    style: Theme.of(context).textTheme.titleLarge),
                Text('₹ ${widget.cost}',
                    style: Theme.of(context).textTheme.titleLarge),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      savedItineraryService.toggleSavedItinerary(widget.id);
                      setState(() {
                        fav = !fav;
                      });
                    },
                    icon: Icon(
                      fav ? Icons.favorite : Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
