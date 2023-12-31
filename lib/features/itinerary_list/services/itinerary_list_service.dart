import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/providers/itinerary_provider.dart';

import '../../../env/env.dart';
import '../../../models/itinerary_model.dart';
import '../../../prefs.dart';
import '../../api/api.dart';

class ItineraryListService {
  ItineraryListService();

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
  }

  void addItinerary(
    BuildContext context,
    Map<String, dynamic> body,
  ) async {
    (String?, Map<String, dynamic>?) response = await Api.postRequest(
        url: '${Env.baseUrl}/api/v1/add-itenery',
        headers: {
          'Authorization': 'Bearer ${Prefs.getString('token')}',
          'Content-Type': 'application/json'
        },
        body: body);
    if (response.$1 == null) {
    } else {}
  }

  void fetchSavedItineraryList(BuildContext context) async {
    (String?, Map<String, dynamic>?) response = await Api.getRequest(
      url: '${Env.baseUrl}/api/v1/get-saved-itenaries',
      headers: {
        'Authorization': 'Bearer ${Prefs.getString('token')}',
        'Content-Type': 'application/json'
      },
    ) as (String?, Map<String, dynamic>?);
    if (response.$1 == null) {
      context
          .read<ItineraryProvider>()
          .setSavedItineraryList(response.$2!['iteneries']);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.$1!),
          ),
        );
      }
    }
  }
}
