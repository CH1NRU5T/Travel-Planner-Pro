import 'package:flutter/material.dart';
import 'package:travel_planner_pro/models/itinerary_model.dart';

class ItineraryProvider extends ChangeNotifier {
  List<Itinerary>? itineraryList;
  List<Itinerary>? savedItineraryList;
  void setItineraryList(List<Itinerary> list) {
    itineraryList = list;
    notifyListeners();
  }

  void setSavedItineraryList(List<Itinerary> list) {
    savedItineraryList = list;
    notifyListeners();
  }
}
