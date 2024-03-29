
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
    _initServers();
    ever(servers, (newValue) => _initServers());
  }

  void _initServers(){
    _sort();
    _getMockStatus();
  }

    void saveServer(MockServer server){
      servers.add(server);
      _dataRepository.saveServer(server);
    }
    void updateServer(MockServer server){
      servers.refresh();
      _dataRepository.saveServer(server);
    }

    void removeMockData(MockServer server, MockData removeMockData){
      server.data.remove(removeMockData);
      updateServer(server);
      _dataRepository.remoteDelete(server, removeMockData);
    }

    void delete(MockServer server){
      servers.remove(server);
      _dataRepository.removeServer(server);
    }

    void saveMockData(MockServer server, String name, String url, String response){
      var mockData = MockData(name, url, response);
      _dataRepository.saveMockData(server, mockData);
    }

    void updateMockData(MockServer server, MockData mockData){
      servers.refresh();
      _dataRepository.saveMockData(server, mockData);
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

    /// 清除服务的添加新Mock状态
    void cleanServerAddNewState(){
      for (var element in servers) {
        element.isAddNew.value = false;
      }
    }

    void _getMockStatus() async{
      for (var element in servers) {
       refreshMockData(element);
      }
    }

    void changeMockState(MockServer server, bool changeValue){
      if(server.isMocking.value == changeValue){
        return;
      }
      _dataRepository.setMockState(server, changeValue);
    }

    void changeMockDataState(MockServer server, MockData mockData, bool changeValue){
      if(mockData.enabled == changeValue){
        return;
      }
      mockData.setEnabled(changeValue);
      _dataRepository.saveMockData(server, mockData);
    }

    void refreshMockData(MockServer server, {bool showLoading = false}){
      _dataRepository.getMockList(server, showLoading: showLoading);
      _dataRepository.isMocking(server, showLoading: showLoading);
    }


}