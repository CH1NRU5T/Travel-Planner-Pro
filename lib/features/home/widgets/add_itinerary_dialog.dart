// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/constants/extensions/extensions.dart';
import 'package:travel_planner_pro/features/itinerary_list/services/itinerary_list_service.dart';
import 'package:travel_planner_pro/models/itinerary_model.dart';
import 'package:travel_planner_pro/providers/itinerary_provider.dart';

import '../../../customWidgets/custom_text_form_field.dart';

class AddItineraryDialog extends StatefulWidget {
  const AddItineraryDialog({
    super.key,
  });
  // final Function setScreenState;
  @override
  State<AddItineraryDialog> createState() => _AddItineraryDialogState();
}

class _AddItineraryDialogState extends State<AddItineraryDialog> {
  ItineraryListService itineraryListService = ItineraryListService();
  void onStartDateChanged(DateTime dateTime) {
    setState(() {
      startDate = dateTime;
    });
  }

  void onEndDateChanged(DateTime dateTime) {
    setState(() {
      endDate = dateTime;
    });
  }

  @override
  void initState() {
    super.initState();
    planNameController = TextEditingController();
    travelModeController = TextEditingController();
    destinationController = TextEditingController();
    costController = TextEditingController();
    newValueController = TextEditingController();
  }

  late TextEditingController planNameController;
  late TextEditingController destinationController;
  late TextEditingController travelModeController;
  late TextEditingController costController;
  late TextEditingController newValueController;
  DateTime? selectedDate;

  void setSelectedDate(DateTime dateTime) {
    setState(() {
      selectedDate = dateTime;
    });
  }

  void onTimelineAdd() {
    setState(() {
      details.add(DateAndDetail(
          date: selectedDate!, dayDetail: newValueController.text));
    });
    newValueController.clear();
  }

  List<DateAndDetail> details = [];
  DateTime? startDate;
  DateTime? endDate;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.8,
        height: MediaQuery.sizeOf(context).height * 0.8,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: planNameController,
                    label: 'Plan Name',
                  ),
                ),
                10.width,
                Expanded(
                  child: CustomTextFormField(
                    controller: destinationController,
                    label: 'Destination',
                  ),
                ),
              ],
            ),
            10.height,
            Row(
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: travelModeController,
                    label: 'Travel Mode',
                  ),
                ),
                10.width,
                Expanded(
                  child: CustomTextFormField(
                    controller: costController,
                    label: 'Cost',
                  ),
                ),
              ],
            ),
            10.height,
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(
                          const Duration(
                            days: 365,
                          ),
                        ),
                      ).then((value) {
                        setState(() {
                          startDate = value;
                        });
                      });
                    },
                    child: Text(
                      startDate == null
                          ? 'Select Start Date'
                          : DateFormat('d MMM yyyy').format(
                              startDate!,
                            ),
                    ),
                  ),
                ),
                10.width,
                Expanded(
                  flex: 1,
                  child: TextButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                        ).then((value) {
                          setState(() {
                            endDate = value;
                          });
                        });
                      },
                      child: Text(endDate == null
                          ? 'Select End Date'
                          : DateFormat('d MMM yyyy').format(endDate!))),
                ),
              ],
            ),
            10.height,
            const Divider(),
            10.height,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...details.map(
                      (e) => Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.dayDetail,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Divider(),
                              ),
                            ),
                            Text(
                              DateFormat('d MMM yyyy').format(e.date),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                    10.height,
                    CustomTimeLine(
                      controller: newValueController,
                      onDateSubmitted: setSelectedDate,
                      add: onTimelineAdd,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Itinerary itinerary = Itinerary(
              id: '',
              planName: planNameController.text,
              destination: destinationController.text,
              travelMode: travelModeController.text,
              estimatedCost: int.parse(costController.text),
              travelStartDate: startDate!,
              travelEndDate: endDate!,
              items: details,
            );
            itineraryListService.addItinerary(context, itinerary.toMap());
            context.read<ItineraryProvider>().reload(context);
            // widget.setScreenState();
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}

class CustomTimeLine extends StatefulWidget {
  const CustomTimeLine({
    Key? key,
    required this.controller,
    required this.onDateSubmitted,
    required this.add,
  }) : super(key: key);
  final TextEditingController controller;
  final Function(DateTime) onDateSubmitted;
  final Function add;

  @override
  State<CustomTimeLine> createState() => _CustomTimeLineState();
}

class _CustomTimeLineState extends State<CustomTimeLine> {
  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: CustomTextFormField(
                    controller: widget.controller, label: 'Location')),
            10.width,
            Expanded(
              child: TextButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(
                      const Duration(
                        days: 365,
                      ),
                    ),
                  ).then((value) {
                    widget.onDateSubmitted(value!);
                    setState(() {
                      selectedDate = value;
                    });
                  });
                },
                child: Text(
                  selectedDate == null
                      ? 'Select Date'
                      : DateFormat('d MMM yyyy').format(
                          selectedDate!,
                        ),
                ),
              ),
            ),
          ],
        ),
        10.height,
        IconButton(
            onPressed: () {
              widget.add();
            },
            icon: const Icon(Icons.add))
      ],
    );
  }
}
