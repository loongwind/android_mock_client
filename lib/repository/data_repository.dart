import 'package:mock_client/model/mock_data.dart';
import 'package:mock_client/model/mock_server.dart';
import 'package:mock_client/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';

class DataRepository {
  late Store _store;
  late final Box<MockData> _mockDataBox = _store.box<MockData>();
  late final Box<MockServer> _mockServerBox = _store.box<MockServer>();


  static Future<DataRepository> create() async{
    DataRepository repository = DataRepository();
    await repository.initStore();
    return repository;
  }

  Future<void> initStore() async {
    _store = await openStore(macosApplicationGroup: "FGDTDLOBXDJ.demo");
    return;
  }

  void saveServer(MockServer server) {
    _mockServerBox.put(server);
  }

  void removeServer(MockServer server) {
    _mockServerBox.remove(server.id);
  }

  List<MockServer> getServers(){
    return _mockServerBox.getAll();
  }

  void saveMockData(MockData data) {
    _mockDataBox.put(data);
  }
}
