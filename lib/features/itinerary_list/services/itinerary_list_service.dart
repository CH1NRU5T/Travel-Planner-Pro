import 'package:flutter/material.dart';

import '../../../env/env.dart';
import '../../../models/itinerary_model.dart';
import '../../../prefs.dart';
import '../../api/api.dart';

class ItineraryListService {
  Future<(String?, List<Itinerary>?)> fetchItineraryList(
    BuildContext context,
  ) async {
    (String?, Map<String, dynamic>?) response = await Api.getRequest(
      url: '${Env.baseUrl}/api/v1/created-itenery-list',
      headers: {
        'Authorization': 'Bearer ${Prefs.getString('token')}',
        'Content-Type': 'application/json'
      },
    ) as (String?, Map<String, dynamic>?);
    if (response.$1 == null) {
      List<Itinerary> itineraryList = (response.$2!['data'] as List<dynamic>)
          .map((e) => Itinerary.fromMap(e as Map<String, dynamic>))
          .toList();
      print(itineraryList);
      return (null, itineraryList);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.$1!),
          ),
        );
      }
      return (response.$1, null);
    }

    // else {
    //   ParticularDestination? particularDestination =
    //       pList.firstWhere((element) => element.destination!.id == id);
    //   return (null, particularDestination);
    // }
  }
}
