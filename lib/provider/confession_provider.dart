// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:cupid/Screens/chat_screen.dart';
import 'package:cupid/models/get_all_confession_model.dart';
import 'package:flutter/cupertino.dart';
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
      if (userUuid == '') {
        log('userUuid is empty');
        notifyListeners();
        final response = await http.get(Uri.parse(retrieveUserUrl));
        log('statuscode ${response.statusCode} ');

        if (response.statusCode == 200) {
          log(response.body.toString());
          userUuid = jsonDecode(response.body)['user_uuid'];
          notifyListeners();
          log('userUuid $userUuid');
          postMessage(userUuid, message, nickname, context);
          notifyListeners();
        } else {
          throw Exception('Failed to load');
        }
      } else {
        log('Already have userUuid');
        postMessage(userUuid, message, nickname, context);
        notifyListeners();
      }
    } catch (e) {
      notifyListeners();
    }
  }

  Future<void> postMessage(String userUuid, String message, String nickName,
      BuildContext context) async {
    try {
      if (userUuid.isEmpty) {
        log(userUuid + ' not found');
        return;
      } else {
        var headers = {'Authorization': userUuid};
        var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                'https://qa.api.cupid.koycoders.in/confession/api/v1/sahya/create/'));
        request.fields.addAll({
          'message': message,
          'nickname': nickName,
          'gender': selectedGenderId == 1
              ? 'female'
              : selectedGenderId == 2
                  ? 'others'
                  : 'male'
        });

        request.headers.addAll(headers);
        log(request.toString());

        http.StreamedResponse response = await request.send();
        log('statuscode send message:  ${response.statusCode} ');

        if (response.statusCode == 200) {
          log(await response.stream.bytesToString());
          getAllConfession();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const ChatScreen()),
              (route) => false);
        } else if (response.statusCode == 429) {
          Navigator.pop(context);

          _showTime(context);
          notifyListeners();
        } else {
          log(response.reasonPhrase.toString());
        }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  _showTime(BuildContext context) {
    showDialog(
      builder: (context) => CupertinoAlertDialog(
        title: Column(
          children: const <Widget>[
            // Text("ഒകെ ഡാ."),
            Icon(
              Icons.timer,
              color: Colors.teal,
            ),
          ],
        ),
        content: const Text("അഭിലാഷേ ഒരു 30 സെക്കന്റ് താ.. 🙏 "),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text("hmm എടുത്തോ 😏"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      context: context,
    );
  }
}
