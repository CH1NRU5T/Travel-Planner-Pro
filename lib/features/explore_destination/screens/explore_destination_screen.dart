import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/customWidgets/custom_text_form_field.dart';
import 'package:travel_planner_pro/customWidgets/loader.dart';
import 'package:travel_planner_pro/features/explore_destination/widgets/explore_destination_card.dart';
import 'package:travel_planner_pro/providers/destination_provider.dart';

class ExploreDestinationScreen extends StatefulWidget {
  const ExploreDestinationScreen({super.key});

  @override
  State<ExploreDestinationScreen> createState() =>
      _ExploreDestinationScreenState();
}

class _ExploreDestinationScreenState extends State<ExploreDestinationScreen> {
  late TextEditingController _controller;
  late DestinationProvider _destinationProvider;
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _destinationProvider = context.watch<DestinationProvider>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: CustomTextFormField(
                controller: _controller,
                label: 'Search',
              ),
            ),
          ),
          _destinationProvider.destinationList == null
              ? const Center(child: Loader())
              : Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 20,
                      runSpacing: 1,
                      children: _destinationProvider.destinationList!.map(
                        (e) {
                          return ExploreDestinationCard(
                              src: e.images.first,
                              name: e.destinationName,
                              avgTravelExpenses: e.avgTravelExpenses);
                        },
                      ).toList(),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
