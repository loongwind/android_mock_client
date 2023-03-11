
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:mock_client/controller/mock_controller.dart';
import 'package:mock_client/model/mock_server.dart';
import 'package:mock_client/repository/data_repository.dart';

void showContentDialog(BuildContext context) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController addrController = TextEditingController();
  final result = await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      title: const Text('创建服务'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('名称:'),
              SizedBox(width: 10),
              Container(
                width: 250,
                child: TextBox(
                  controller: nameController,
                  placeholder: "请输入名称",
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children:  [
              Text('地址:'),
              SizedBox(width: 10),
              Container(
                width: 250,
                child: TextBox(
                  controller: addrController,
                  placeholder: "192.168.1.8:8080",
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        Button(
          child: const Text('取消'),
          onPressed: () =>  Navigator.pop(context),
        ),
        FilledButton(
          child: const Text('确定'),
          onPressed: (){
            MockController controller = Get.find();
            String name = nameController.text;
            String addr = addrController.text;
            controller.saveServer(MockServer(name, addr));
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}