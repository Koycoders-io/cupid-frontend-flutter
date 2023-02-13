// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:cupid/models/get_all_confession_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ConfessionProvider extends ChangeNotifier {
  /// -[selectedGenderId] = 0 Male
  /// -[selectedGenderId] = 1 Female
  /// -[selectedGenderId] = 2 Others
  int selectedGenderId = 1;
  String userUuid = '';
  set setGenderId(int value) {
    selectedGenderId = value;
    notifyListeners();
  }

  final String getAllConfessionUrl =
      'https://qa.api.cupid.koycoders.in/confession/api/v1/sahya/list/';
  final String retrieveUserUrl =
      'https://qa.api.cupid.koycoders.in/confession/api/v1/user/retrieve/';
  GetAllConfession? getConfessionData;
  GetAllConfession? getPaginatedData;

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

  bool isPaginationLoading = false;
  Future<void> getPaginated(String nextPageUrl) async {
    try {
      isPaginationLoading = true;

      notifyListeners();
      final response = await http.get(Uri.parse(nextPageUrl));
      if (response.statusCode == 200) {
        log(response.body.toString());
        getPaginatedData = getAllConfessionFromJson(response.body);
        if (getPaginatedData!.results.isNotEmpty) {
          getConfessionData!.results.addAll(getPaginatedData!.results);
          getConfessionData!.next = getPaginatedData!.next;
          log('getConfessionData!.next ${getConfessionData!.next}');
          notifyListeners();
        }
        isPaginationLoading = false;
        notifyListeners();
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      isPaginationLoading = false;
      notifyListeners();
    }
  }

  Future<void> retriveUser(
      {required String message,
      required String nickname,
      required BuildContext context}) async {
    try {
      notifyListeners();
      final response = await http.get(Uri.parse(retrieveUserUrl));
      if (response.statusCode == 200) {
        log(response.body.toString());
        userUuid = jsonDecode(response.body)['user_uuid'];
        log('userUuid $userUuid');
        postMessage(userUuid, message, context);
        notifyListeners();
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> postMessage(
      String userUuid, String message, BuildContext context) async {
    try {
      if (userUuid.isEmpty) {
        return;
      } else {
        log('userUuid $userUuid');

        var headers = {'Authorization': userUuid};
        var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                'https://qa.api.cupid.koycoders.in/confession/api/v1/sahya/create/'));
        request.fields.addAll({
          'message': message,
          'nickname': 'ambili',
          'gender': selectedGenderId == 1
              ? 'female'
              : selectedGenderId == 2
                  ? 'others'
                  : 'male'
        });

        request.headers.addAll(headers);

        http.StreamedResponse response = await request.send();

        if (response.statusCode == 200) {
          log(await response.stream.bytesToString());
          getAllConfession();
          Navigator.pop(context);
        } else {
          log(response.reasonPhrase.toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
