
import 'package:get/get.dart';
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


    void add(MockServer server){
      servers.add(server);
      _dataRepository.saveServer(server);
    }
}