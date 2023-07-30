import 'package:flutter/material.dart';

class KeywordsProvider extends ChangeNotifier {
  List<String>? keywordsList;
  void setKeywordsList(List<String> list) {
    keywordsList = list;
    notifyListeners();
  }
}
