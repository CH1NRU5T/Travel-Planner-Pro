import 'package:flutter/material.dart';

import '../../../env/env.dart';
import '../../../models/itinerary_model.dart';
import '../../api/api.dart';

class ItineraryService {
  Future<(String?, Itinerary?)> getItinerary(
    BuildContext context,
    String id,
  ) async {
    (String?, Map<String, dynamic>?) response = await Api.postRequest(
      url: '${Env.baseUrl}/api/v1/see-itenery',
      headers: {'Content-Type': 'application/json'},
      body: {
        'iteneryId': id,
      },
    ) as (String?, Map<String, dynamic>?);
    if (response.$1 == null) {
      return (null, Itinerary.fromMap(response.$2!));
    } else {
      print('err${response.$1}');
      return (response.$1, null);
    }
  }
}
