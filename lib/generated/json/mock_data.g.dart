import 'package:mock_client/generated/json/base/json_convert_content.dart';
import 'package:mock_client/model/mock_data.dart';

MockData $MockDataFromJson(Map<String, dynamic> json) {
  final MockData mockData = MockData("","","");
  final int? id = jsonConvert.convert<int>(json['id']);
  if (id != null) {
    mockData.id = id;
  }
  final String? uuid = jsonConvert.convert<String>(json['uuid']);
  if (uuid != null) {
    mockData.uuid = uuid;
  }
  final String? name = jsonConvert.convert<String>(json['name']);
  if (name != null) {
    mockData.name = name;
  }
  final String? url = jsonConvert.convert<String>(json['url']);
  if (url != null) {
    mockData.url = url;
  }
  final String? response = jsonConvert.convert<String>(json['response']);
  if (response != null) {
    mockData.response = response;
  }
  final bool? enabled = jsonConvert.convert<bool>(json['enabled']);
  if (enabled != null) {
    mockData.enabled = enabled;
  }
  return mockData;
}

Map<String, dynamic> $MockDataToJson(MockData entity) {
  final Map<String, dynamic> data = <String, dynamic>{};
  // data['id'] = entity.id;
  data['uuid'] = entity.uuid;
  data['name'] = entity.name;
  data['url'] = entity.url;
  data['response'] = entity.response;
  data['enabled'] = entity.enabled;
  return data;
}
