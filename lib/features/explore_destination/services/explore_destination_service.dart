import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_planner_pro/providers/keywords_provider.dart';

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
      for (Destination d in destinationList) {
        d.isSaved = true;
      }
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
      );
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

  Future<(String, bool)> addReview(
      {required String review,
      required int rating,
      required String destination_id}) async {
    (String?, Map<String, dynamic>?) response = await Api.postRequest(
      url: '${Env.baseUrl}/api/v1/add-review',
      headers: {
        'Authorization': 'Bearer ${Prefs.getString('token')}',
        'Content-Type': 'application/json'
      },
      body: {
        'destination_id': destination_id,
        'review': review,
        'rating': rating
      },
    );
    if (response.$1 == null) {
      if (response.$2!['message'] == null) {
        return (response.$2!['error'] as String, false);
      } else {
        return (response.$2!['message'] as String, true);
      }
    } else {
      return (response.$1!, false);
    }
  }

  Future<(String, bool)> toggleSaved(String destinationId) async {
    (String?, Map<String, dynamic>?) response = await Api.postRequest(
      url: '${Env.baseUrl}/api/v1/save-destination-toggle',
      headers: {
        'Authorization': 'Bearer ${Prefs.getString('token')}',
        'Content-Type': 'application/json'
      },
      body: {
        'destinationId': destinationId,
      },
    );
    if (response.$1 == null) {
      if (response.$2!['message'] == null) {
        return (response.$2!['error'] as String, false);
      } else {
        return (response.$2!['message'] as String, true);
      }
    } else {
      return (response.$1!, false);
    }
  }

  Future<(String?, List<String>?)> getKeywords(BuildContext context) async {
    (String?, Map<String, dynamic>?) response = await Api.getRequest(
      url: '${Env.baseUrl}/api/v1/get-all-keywords',
      headers: {
        'Authorization': 'Bearer ${Prefs.getString('token')}',
      },
    ) as (String?, Map<String, dynamic>?);

    if (response.$1 == null) {
      List<String> keywords = List.from(response.$2!['keywords']);
      context.read<KeywordsProvider>().setKeywordsList(keywords);
      return (null, keywords);
    } else {
      return (response.$1!, null);
    }
  }

  Future<(String?, List<dynamic>?)> searchViaKeyword(
      BuildContext context, String word) async {
    (String?, Map<String, dynamic>?) response = await Api.postRequest(
      url: '${Env.baseUrl}/api/v1/search-destination',
      headers: {
        'Authorization': 'Bearer ${Prefs.getString('token')}',
        'Content-Type': 'application/json',
      },
      body: {
        'keyword': word,
      },
    );

    if (response.$1 == null) {
      List<dynamic> list = List.from(
        response.$2!['destinations'].map(
          (e) => Destination.fromMap(e),
        ),
      );
      // search from saved destiantions
      List<Destination> savedList =
          context.read<DestinationProvider>().savedDestinationList!;
      for (Destination d in list) {
        for (Destination s in savedList) {
          if (d.id == s.id) {
            d.isSaved = true;
          }
        }
      }
      return (null, list);
    } else {
      return (response.$1!, null);
    }
  }
}
