import 'package:flutter/material.dart';
import 'package:travel_planner_pro/models/destination_model.dart';
import 'package:travel_planner_pro/models/particular_destination_model.dart';

class DestinationProvider extends ChangeNotifier {
  List<Destination>? destinationList;
  List<Destination>? savedDestinationList;
  List<ParticularDestination>? particularDestinationList;
  Destination? particularDestination;
  void setDestinationList(List<Destination> list) {
    destinationList = list;
    notifyListeners();
  }

  void setSavedDestinationList(List<Destination> list) {
    savedDestinationList = list;
    notifyListeners();
  }

  set particularDestinationSetter(Destination destination) {
    particularDestination = destination;
    notifyListeners();
  }

  set particularDestinationListSetter(List<ParticularDestination> list) {
    particularDestinationList = list;
    notifyListeners();
  }
}
