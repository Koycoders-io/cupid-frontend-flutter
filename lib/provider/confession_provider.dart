import 'dart:developer';

import 'package:cupid/models/get_all_confession_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfessionProvider extends ChangeNotifier {
  final String getAllConfessionUrl =
      'http://139.144.5.225/confession/api/v1/sahya/list/';
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
