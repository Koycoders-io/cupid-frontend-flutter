import 'dart:developer';

import 'package:cupid/models/get_all_confession_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfessionProvider extends ChangeNotifier {
  /// -[selectedGenderId] = 0 Male
  /// -[selectedGenderId] = 1 Female
  /// -[selectedGenderId] = 2 Others
  int selectedGenderId = 1;

  set setGenderId(int value) {
    selectedGenderId = value;
    notifyListeners();
  }

  final String getAllConfessionUrl =
      'https://qa.api.cupid.koycoders.in/confession/api/v1/sahya/list/';
  GetAllConfession? getConfessionData;

  bool isLoading = false;
  Future<void> getAllConfession() async {
    try {
      isLoading = true;

      notifyListeners();
      final response = await http.get(Uri.parse(getAllConfessionUrl));
      if (response.statusCode == 200) {
        log(response.body.toString());
        getConfessionData = getAllConfessionFromJson(response.body);
        isLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }
}
