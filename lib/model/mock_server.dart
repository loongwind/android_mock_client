import 'package:get/get.dart';
import 'package:mock_client/model/mock_data.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MockServer {
  @Id()
  int id = 0;

  String name;
  String addr;

  final data = ToMany<MockData>();

  @Transient()
  int sort = 0;

  @Transient()
  final isAddNew = false.obs;

  @Transient()
  final isMocking = false.obs;

  MockServer(this.name, this.addr);
}