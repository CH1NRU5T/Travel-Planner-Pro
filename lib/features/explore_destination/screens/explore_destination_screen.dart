import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/customWidgets/custom_text_form_field.dart';
import 'package:travel_planner_pro/customWidgets/loader.dart';
import 'package:travel_planner_pro/features/explore_destination/services/explore_destination_service.dart';
import 'package:travel_planner_pro/features/explore_destination/widgets/explore_destination_card.dart';
import 'package:travel_planner_pro/providers/destination_provider.dart';
import 'package:travel_planner_pro/providers/keywords_provider.dart';

class ExploreDestinationScreen extends StatefulWidget {
  const ExploreDestinationScreen({super.key});

  @override
  State<ExploreDestinationScreen> createState() =>
      _ExploreDestinationScreenState();
}

class _ExploreDestinationScreenState extends State<ExploreDestinationScreen> {
  late TextEditingController _controller;
  late DestinationProvider _destinationProvider;
  final ExploreDestinationService serv = ExploreDestinationService();
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

  List<dynamic>? searched;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onSelect(String option) async {
    (String?, List<dynamic>?) record =
        await serv.searchViaKeyword(context, option);
    if (record.$1 == null) {
      setState(() {
        searched = record.$2!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.6,
              child: CustomTextFormField(
                controller: _controller,
                search: true,
                onSelected: onSelect,
                kOptions: context.read<KeywordsProvider>().keywordsList,
                label: 'Search',
              ),
            ),
          ),
        ),
        _destinationProvider.destinationList == null && searched == null
            ? const Center(child: Loader())
            : Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 20,
                    children: searched != null
                        ? searched!.map(
                            (e) {
                              return ExploreDestinationCard(destination: e);
                            },
                          ).toList()
                        : _destinationProvider.destinationList!.map(
                            (e) {
                              return ExploreDestinationCard(destination: e);
                            },
                          ).toList(),
                  ),
                ),
              ),
      ],
    );
  }
}
