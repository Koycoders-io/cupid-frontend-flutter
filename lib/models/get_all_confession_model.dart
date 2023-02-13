// To parse this JSON data, do
//
//     final getAllConfession = getAllConfessionFromJson(jsonString);

import 'dart:convert';

GetAllConfession getAllConfessionFromJson(String str) =>
    GetAllConfession.fromJson(json.decode(str));

String getAllConfessionToJson(GetAllConfession data) =>
    json.encode(data.toJson());

class GetAllConfession {
  GetAllConfession({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  final int count;
  String next;
  final String previous;
  final List<Result> results;

  factory GetAllConfession.fromJson(Map<String, dynamic> json) =>
      GetAllConfession(
        count: json["count"] ?? 0,
        next: json["next"] ?? 'null',
        previous: json["previous"] ?? '',
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.nickname,
    required this.message,
  });

  final String? nickname;
  final String? message;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        nickname: json["nickname"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "nickname": nickname,
        "message": message,
      };
}
