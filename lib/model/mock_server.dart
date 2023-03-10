import 'package:objectbox/objectbox.dart';

@Entity()
class MockServer {
  @Id()
  int id = 0;

  String name;
  String addr;

  MockServer(this.name, this.addr);
}