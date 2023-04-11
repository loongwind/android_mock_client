import 'package:get/get.dart';
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
    _store = await openStore(macosApplicationGroup: "FGDTDLOBXDJ.demo", directory: "${(await getApplicationDocumentsDirectory()).path}/android_mock_client");
    return;
  }

  void saveServer(MockServer server) {
    _mockServerBox.put(server);
    List<MockData> newData = server.data.where((element) => element.isNew).toList();
    if(newData.isNotEmpty){
      _remoteAdd(server, newData);
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
    _remoteAdd(server, [data]);
  }

  void _remoteAdd(MockServer server, List<MockData> data) {
    request(() async {
      bool isSuccess = await requestClient.post("http://${server.addr}${APIS.add}", data: data, headers: {"Content-Type":"application/json"});
      if(isSuccess){
        for (var element in data) {
          element.isActive.value = true;
          element.isNew = false;
        }
      }
    });
  }

  void remoteDelete(MockServer server, MockData data) {
    request(() async {
      await requestClient.post("http://${server.addr}${APIS.remove}", data: {"uuid":data.uuid}, headers: {"Content-Type":"application/x-www-form-urlencoded"});
    });
  }

  void isMocking(MockServer server, {bool showLoading = false}) async{
    request(() async {
      bool isMocking =  await requestClient.get<bool>("http://${server.addr}${APIS.getMockStatus}") ?? false;
      server.isMocking.value = isMocking;
    }, showLoading: showLoading, onError: (e)=> server.isMocking.value = false);
  }

  void setMockState(MockServer server, bool mocking) async{
    request(() async {
      bool isSuccess =  await requestClient.post<bool>("http://${server.addr}${APIS.setMockStatus}", data: {"mocking": mocking}, headers: {"Content-Type":"application/x-www-form-urlencoded"}) ?? false;
      if(isSuccess){
        server.isMocking.value = mocking;
      }
    });
  }

  void getMockList(MockServer server, {bool showLoading = false}){
    request(() async {
      List<MockData> list = await requestClient.post<List<MockData>>("http://${server.addr}${APIS.list}", headers: {"Content-Type":"application/json"}) ?? List.empty();
      for (var mockData in server.data) {
        MockData? element = list.firstWhereOrNull((element) => element.uuid == mockData.uuid);
        mockData.isActive.value = element != null;
        mockData.setEnabled(element?.enabled ?? false);
      }
    }, showLoading: showLoading);
  }
}
