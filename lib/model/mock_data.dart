import 'dart:convert';

import 'package:get/get.dart';
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
  bool enabled;
  bool isJsonMode;

  @Transient()
  int sort = 0;

  @Transient()
  bool isNew = false;

  @Transient()
  final isActive = false.obs;

  @Transient()
  final enabledObs = false.obs;

  MockData(this.name, this.url, this.response, {this.id = 0, this.uuid = "", this.enabled = true, this.isJsonMode = true}) {
    if (uuid.isEmpty) {
      uuid = const Uuid().v1();
    }
  }

  void setEnabled(bool enabled){
    this.enabled = enabled;
    enabledObs.value = enabled;
  }

  factory MockData.fromJson(Map<String, dynamic> json) => $MockDataFromJson(json);

  Map<String, dynamic> toJson() => $MockDataToJson(this);

  @override
  String toString() {
    return jsonEncode(this);
  }
}