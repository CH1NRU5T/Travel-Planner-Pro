import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/models/itinerary_model.dart';

import '../../../env/env.dart';
import '../../../prefs.dart';
import '../../../providers/itinerary_provider.dart';
import '../../api/api.dart';

class SavedItineraryService {
  void getSavedItineraryList(BuildContext context) async {
    (String?, Map<String, dynamic>?) response = await Api.getRequest(
      url: '${Env.baseUrl}/api/v1/get-saved-itenaries',
      headers: {
        'Authorization': 'Bearer ${Prefs.getString('token')}',
        'Content-Type': 'application/json'
      },
    ) as (String?, Map<String, dynamic>?);

    if (response.$1 == null) {
      context.read<ItineraryProvider>().setSavedItineraryList(
          List<Itinerary>.from(response.$2!['iteneries']));
    } else {}
  }
}
