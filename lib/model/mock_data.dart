import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';

@Entity()
class MockData {
  @Id()
  int id = 0;
  String uuid;

  String url;
  String response;

  MockData(this.url, this.response, {this.id = 0, this.uuid = ""}) {
    if (uuid.isEmpty) {
      uuid = const Uuid().v1();
    }
  }
}