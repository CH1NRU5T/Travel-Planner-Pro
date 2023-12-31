import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/customWidgets/loader.dart';
import 'package:travel_planner_pro/features/empty/screens/empty_screen.dart';

import '../../../providers/destination_provider.dart';
import '../../explore_destination/widgets/explore_destination_card.dart';

class SavedDestinationScreen extends StatefulWidget {
  const SavedDestinationScreen({super.key});

  @override
  State<SavedDestinationScreen> createState() => _SavedDestinationScreenState();
}

class _SavedDestinationScreenState extends State<SavedDestinationScreen> {
  late DestinationProvider _destinationProvider;
  @override
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _destinationProvider = context.watch<DestinationProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return _destinationProvider.savedDestinationList == null
        ? const Loader()
        : Consumer<DestinationProvider>(
            builder: (context, value, child) {
              return value.savedDestinationList!.isEmpty
                  ? const EmptyScreen()
                  : Padding(
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 20,
                          runSpacing: 1,
                          children: value.savedDestinationList!.map(
                            (e) {
                              return ExploreDestinationCard(
                                destination: e,
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    );
            },
            // child: Padding(
            //     padding: const EdgeInsets.all(20),
            //     child: SingleChildScrollView(
            //       physics: const BouncingScrollPhysics(),
            //       child: Wrap(
            //         direction: Axis.horizontal,
            //         alignment: WrapAlignment.start,
            //         spacing: 20,
            //         runSpacing: 1,
            //         children: _destinationProvider.savedDestinationList!.map(
            //           (e) {
            //             return ExploreDestinationCard(
            //               destination: e,
            //             );
            //           },
            //         ).toList(),
            //       ),
            //     ),
            //   ),
          );
  }
}
