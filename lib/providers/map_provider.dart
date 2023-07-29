import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/env/env.dart';
import 'package:travel_planner_pro/features/api/api.dart';
import 'package:travel_planner_pro/models/destination_model.dart';

import 'auth_provider.dart';

class MapProvider extends ChangeNotifier {
  Future<(String?, List<Destination>?)> fetchLocationList(
      BuildContext context) async {
    (String?, dynamic) response = await Api.getRequest(
        url: '${Env.baseUrl}/api/v1/get-all-destinations',
        headers: {
          'Authorization': 'Bearer ${context.read<AuthProvider>().user!.token}'
        });
    if (response.$1 == null) {
      // success
      Map<String, dynamic> json = response.$2;
      List<Destination> destinationList = [];
      json['data'].forEach((element) {
        destinationList.add(Destination.fromMap(element));
      });
      return (null, destinationList);
    } else {
      // error
      return (response.$1, null);
    }
  }
}
