import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/env/env.dart';
import 'package:travel_planner_pro/features/api/api.dart';
import 'package:travel_planner_pro/models/destination_model.dart';
import 'package:travel_planner_pro/providers/auth_provider.dart';

class DestinationProvider extends ChangeNotifier {
  List<Destination>? destinationList;
  List<Destination>? savedDestinationList;
  void setDestinationList(List<Destination> list) {
    destinationList = list;
    notifyListeners();
  }

  void setSavedDestinationList(List<Destination> list) {
    savedDestinationList = list;
    notifyListeners();
  }

  void fetchDestinationList(BuildContext context) async {
    (String?, Map<String, dynamic>?) response = await Api.getRequest(
      url: '${Env.baseUrl}/api/v1/get-all-destinations',
      headers: {
        'Authorization': 'Bearer ${context.read<AuthProvider>().user!.token}'
      },
    ) as (String?, Map<String, dynamic>?);
    if (response.$1 == null) {
      List<dynamic> list =
          List.from(response.$2!['data'].map((e) => Destination.fromMap(e)));
      List<Destination> destinationList =
          list.map((e) => e as Destination).toList();

      setDestinationList(destinationList);
    }
  }

  void fetchSavedDestinationList(BuildContext context) async {
    (String?, Map<String, dynamic>?) response = await Api.getRequest(
      url: '${Env.baseUrl}/api/v1/get-saved-destinations',
      headers: {
        'Authorization': 'Bearer ${context.read<AuthProvider>().user!.token}'
      },
    ) as (String?, Map<String, dynamic>?);
    if (response.$1 == null) {
      List<dynamic> list = List.from(
          response.$2!['destinations'].map((e) => Destination.fromMap(e)));
      List<Destination> destinationList =
          list.map((e) => e as Destination).toList();

      setSavedDestinationList(destinationList);
    }
  }
}
