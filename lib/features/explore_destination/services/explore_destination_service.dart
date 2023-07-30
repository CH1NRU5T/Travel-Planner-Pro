import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../env/env.dart';
import '../../../models/destination_model.dart';
import '../../../models/particular_destination_model.dart';
import '../../../models/review_model.dart';
import '../../../prefs.dart';
import '../../../providers/destination_provider.dart';
import '../../api/api.dart';

class ExploreDestinationService {
  Future<(String?, List<Destination>?)> fetchSavedDestinationList(
      BuildContext context) async {
    (String?, Map<String, dynamic>?) response = await Api.getRequest(
      url: '${Env.baseUrl}/api/v1/get-saved-destinations',
      headers: {'Authorization': 'Bearer ${Prefs.getString('token')}'},
    ) as (String?, Map<String, dynamic>?);
    if (response.$1 == null) {
      List<dynamic> list = List.from(
          response.$2!['destinations'].map((e) => Destination.fromMap(e)));
      List<Destination> destinationList =
          list.map((e) => e as Destination).toList();
      if (context.mounted) {
        context
            .read<DestinationProvider>()
            .setSavedDestinationList(destinationList);
      }

      return (null, destinationList);
    } else {
      return (response.$1, null);
    }
  }

  Future<(String?, List<Destination>?)> fetchDestinationList(
      BuildContext context) async {
    (String?, Map<String, dynamic>?) response = await Api.getRequest(
      url: '${Env.baseUrl}/api/v1/get-all-destinations',
      headers: {'Authorization': 'Bearer ${Prefs.getString('token')}'},
    ) as (String?, Map<String, dynamic>?);
    if (response.$1 == null) {
      List<dynamic> list =
          List.from(response.$2!['data'].map((e) => Destination.fromMap(e)));
      List<Destination> destinationList =
          list.map((e) => e as Destination).toList();
      if (context.mounted) {
        context.read<DestinationProvider>().setDestinationList(destinationList);
      }
      return (null, destinationList);
    } else {
      return (response.$1, null);
    }
  }

  Future<(String?, ParticularDestination?)> fetchParticularDestination(
      BuildContext context,
      String id,
      List<ParticularDestination>? pList) async {
    if (pList == null || pList.isEmpty) {
      (String?, Map<String, dynamic>?) response = await Api.postRequest(
        url: '${Env.baseUrl}/api/v1/get-destination',
        headers: {
          'Authorization': 'Bearer ${Prefs.getString('token')}',
          'Content-Type': 'application/json'
        },
        body: {'destination_id': id},
      ) as (String?, Map<String, dynamic>?);
      if (response.$1 == null) {
        Destination destination =
            Destination.fromMap(response.$2!['data']['destinationDtoObj']);
        List<dynamic> reviews = response.$2!['data']['reviewsDtoObj'];
        List<Review> reviewList =
            reviews.map((e) => Review.fromMap(e)).toList();
        ParticularDestination particularDestination = ParticularDestination(
          destination: destination,
          currentWeather: response.$2!['data']['destinationDtoObj']
              ['currentWeather'],
          currentTemperature: response.$2!['data']['destinationDtoObj']
              ['currentTemperature'],
          weatherIcon: response.$2!['data']['destinationDtoObj']['weatherIcon'],
          reviews: reviewList,
        );

        return (null, particularDestination);
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response.$1!)));
        }
        return (response.$1, null);
      }
    } else {
      ParticularDestination? particularDestination =
          pList.firstWhere((element) => element.destination!.id == id);
      return (null, particularDestination);
    }
  }
}
