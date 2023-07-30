import 'package:flutter/cupertino.dart';

import '../../../env/env.dart';
import '../../../prefs.dart';
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
    // print(response);
    // if (response.$1 == null) {
    //   print(response.$2);
    //   context
    //       .read<ItineraryProvider>()
    //       .setSavedItineraryList(response.$2!['iteneries']);
    // } else {
    //   print(response.$1);
    // }
  }
}
