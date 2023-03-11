
import 'package:get/get.dart';
import 'package:mock_client/model/mock_data.dart';
import 'package:mock_client/model/mock_server.dart';
import 'package:mock_client/repository/data_repository.dart';

class MockController extends GetxController {
    final _dataRepository = Get.find<DataRepository>();
    final servers = <MockServer>[].obs;


    @override
  void onInit() {
    super.onInit();
    var list = _dataRepository.getServers();
    servers.addAll(list);
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

}