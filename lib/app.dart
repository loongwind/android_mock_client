

import 'package:get/get.dart';
import 'package:mock_client/controller/mock_controller.dart';
import 'package:mock_client/repository/data_repository.dart';

Future<void> init() async{
  await Get.putAsync(() async{
    return await DataRepository.create();
  });
  Get.put(MockController());
  return;
}