
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:mock_client/controller/mock_controller.dart';
import 'package:mock_client/model/mock_server.dart';

void showContentDialog(BuildContext context, {MockServer? server}) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController addrController = TextEditingController();
  if(server != null){
    nameController.text = server.name;
    addrController.text = server.addr;
  }
  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      title: Text(server == null ? '新增服务' : "编辑服务"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const Text('名称:'),
              const SizedBox(width: 10),
              SizedBox(
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
              const Text('地址:'),
              const SizedBox(width: 10),
              SizedBox(
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
            if(server != null){
              server.name = name;
              server.addr = addr;
              controller.updateServer(server);
            }else{
              MockServer saveServer = MockServer(name, addr);
              controller.saveServer(saveServer);
            }
            Navigator.pop(context);
          },
        ),
      ],
    ),
  );
}