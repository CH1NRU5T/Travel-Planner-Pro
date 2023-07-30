import 'package:flutter/material.dart';
import 'package:travel_planner_pro/models/itinerary_model.dart';

class ItineraryProvider extends ChangeNotifier {
  List<Itinerary>? itineraryList;

  void setItineraryList(List<Itinerary> list) {
    itineraryList = list;
    notifyListeners();
  }
}
