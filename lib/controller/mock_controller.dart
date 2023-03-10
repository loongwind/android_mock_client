
import 'package:get/get.dart';
import 'package:mock_client/model/mock_data.dart';
import 'package:mock_client/model/mock_server.dart';
import 'package:mock_client/repository/data_repository.dart';

class MockController extends GetxController {
    final _dataRepository = Get.find<DataRepository>();
    final servers = <MockServer>[].obs;
    final selectedIndex = 0.obs;


    @override
  void onInit() {
    super.onInit();
    var list = _dataRepository.getServers();
    servers.addAll(list);
    _sort();
    ever(servers, (newValue) => _sort());
  }


    void saveServer(MockServer server){
      servers.add(server);
      _dataRepository.saveServer(server);
    }
    void updateServer(MockServer server){
      servers.refresh();
      _dataRepository.saveServer(server);
    }
    void delete(MockServer server){
      servers.remove(server);
      _dataRepository.removeServer(server);
    }

    void saveMockData(String name, String url, String response){
      var mockData = MockData(name, url, response);
      _dataRepository.saveMockData(mockData);
    }

    void updateMockData(MockData mockData){
      servers.refresh();
      _dataRepository.saveMockData(mockData);
    }

    void _sort(){
      int i = 0;
      for (var server in servers) {
        server.sort = i++;
        for (var data in server.data) {
          data.sort = i ++;
        }
      }
    }

    void cleanServerAddNewState(){
      for (var element in servers) {
        element.isAddNew.value = false;
      }
    }

}