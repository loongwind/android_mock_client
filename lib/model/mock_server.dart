import 'package:mock_client/model/mock_data.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MockServer {
  @Id()
  int id = 0;

  String name;
  String addr;

  final data = ToMany<MockData>();

  MockServer(this.name, this.addr);
}