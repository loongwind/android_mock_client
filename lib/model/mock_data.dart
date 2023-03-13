import 'dart:convert';

import 'package:mock_client/generated/json/mock_data.g.dart';
import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

@Entity()
class MockData {
  @Id()
  int id = 0;
  String uuid;
  String name;

  String url;
  String response;

  @Transient()
  int sort = 0;

  MockData(this.name, this.url, this.response, {this.id = 0, this.uuid = ""}) {
    if (uuid.isEmpty) {
      uuid = const Uuid().v1();
    }
  }

  factory MockData.fromJson(Map<String, dynamic> json) => $MockDataFromJson(json);

  Map<String, dynamic> toJson() => $MockDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}