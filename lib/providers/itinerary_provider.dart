import 'package:flutter/material.dart';
import 'package:travel_planner_pro/models/itinerary_model.dart';

import '../features/itinerary_list/services/itinerary_list_service.dart';

class ItineraryProvider extends ChangeNotifier {
  ItineraryListService iS = ItineraryListService();
  List<Itinerary>? itineraryList;
  List<Itinerary>? savedItineraryList;
  void setItineraryList(List<Itinerary> list) {
    itineraryList = list;
    notifyListeners();
  }

  void setSavedItineraryList(List<dynamic> list) {
    savedItineraryList = list as List<Itinerary>;
    notifyListeners();
  }

  Future<void> reload(BuildContext context) async {
    (String?, List<Itinerary>?) record = await iS.fetchItineraryList(context);
    if (record.$1 == null) {
      setItineraryList(record.$2!);
      notifyListeners();
    }
  }
}
