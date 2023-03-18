import 'package:mock_client/http/apis.dart';
import 'package:mock_client/http/request.dart';
import 'package:mock_client/http/request_client.dart';
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
    List<MockData> newData = server.data.where((element) => element.isNew).toList();
    if(newData.isNotEmpty){
      _submit(server, newData);
    }
  }

  void removeServer(MockServer server) {
    _mockServerBox.remove(server.id);
  }

  List<MockServer> getServers(){
    return _mockServerBox.getAll();
  }

  void saveMockData(MockServer server, MockData data) {
    _mockDataBox.put(data);
    _submit(server, [data]);
  }

  void _submit(MockServer server, List<MockData> data) {
    request(() async {
      await requestClient.post("http://${server.addr}${APIS.add}", data: data, headers: {"Content-Type":"application/json"});
    });
  }
}
