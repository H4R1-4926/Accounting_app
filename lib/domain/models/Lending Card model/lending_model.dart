// ignore_for_file: invalid_annotation_target

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'lending_model.freezed.dart';
part 'lending_model.g.dart';

@freezed
class LendingModel with _$LendingModel {
  factory LendingModel({
    bool? IsMoneyLent,
    String? id,
    String? name,
    String? phone,
    String? description,
    String? amount,
    String? installmentAmount,
    String? installmentType,
    @JsonKey(fromJson: _timestampListFromJson, toJson: _timestampListToJson)
    List<Timestamp>? listOfTImestamp,
    String? shareCode,
    bool? asJoiner,
    String? balanceAmount,
    @JsonKey(fromJson: timestampFromJson, toJson: timestampToJson)
    Timestamp? datetime,
    String? lastMoneyGivenDate,
    String? userId,
    String? duplicateFrom,
    String? searchQuery,
  }) = _LendingModel;

  factory LendingModel.fromJson(Map<String, dynamic> json) =>
      _$LendingModelFromJson(json);
}

List<Timestamp>? _timestampListFromJson(List<dynamic>? jsonList) {
  if (jsonList == null) return null;

  return jsonList.map((e) {
    if (e is Timestamp) return e;
    if (e is String) return Timestamp.fromDate(DateTime.parse(e));
    throw Exception('Invalid data type for timestamp');
  }).toList();
}

List<dynamic>? _timestampListToJson(List<Timestamp>? list) {
  return list
      ?.map((timestamp) => timestamp.toDate().toIso8601String())
      .toList();
}

Timestamp? timestampFromJson(dynamic json) {
  if (json == null) {
    return null;
  }
  return json is Timestamp ? json : Timestamp.fromMillisecondsSinceEpoch(json);
}

dynamic timestampToJson(Timestamp? timestamp) {
  return timestamp?.millisecondsSinceEpoch;
}
