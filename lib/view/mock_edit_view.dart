import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:mock_client/controller/mock_controller.dart';
import 'package:mock_client/model/mock_data.dart';
import 'package:mock_client/model/mock_server.dart';

class MockEditWidget extends StatefulWidget {
  final MockServer mockServer;
  final MockData? mockData;

  const MockEditWidget(this.mockServer, {Key? key, this.mockData})
      : super(key: key);

  @override
  State<MockEditWidget> createState() => _MockEditWidgetState();
}

class _MockEditWidgetState extends State<MockEditWidget> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  final TextEditingController responseController = TextEditingController();

  final MockController mockController = Get.find();
  bool isWindows = defaultTargetPlatform == TargetPlatform.windows;
  late int responseLines = isWindows ? 26 : 29;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.mockData?.name ?? "";
    urlController.text = widget.mockData?.url ?? "";
    responseController.text = widget.mockData?.response ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        buildServer(),
        const SizedBox(height: 15,),
        buildTextBox("名称", nameController, placeholder: "请输入名称"),
        const SizedBox(height: 15,),
        buildTextBox("URL", urlController, placeholder: "请输入URL"),
        const SizedBox(height: 15,),
        buildResponse(),
        buildSubmit()
      ],
    );
  }

  Widget buildServer() {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0),
      child: Text("目标设备：${widget.mockServer.name}（${widget.mockServer.addr}）"),
    );
  }

  Widget buildTextBox(String label, TextEditingController controller, {String? placeholder}){
    return Row(
      children: [
        const SizedBox(width: 60,),
        Text('$label:'),
        const SizedBox(width: 10),
        SizedBox(
          width: 400,
          child: TextBox(
            controller: controller,
            placeholder: placeholder,
          ),
        )
      ],
    );
  }

  Widget buildResponse() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text('Response:'),
          ),
          const SizedBox(height: 10),
          Expanded(
            // padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextBox(
                  controller: responseController,
                  maxLines: null,
                  minLines: null),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSubmit() {
    return Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 30),
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: FilledButton(
        onPressed: submit,
        child: const Text('提交'),
      ),
    );
  }

  void submit() {
    String name = nameController.text;
    String url = urlController.text;
    String response = responseController.text;

    if (widget.mockData == null) {
      widget.mockServer.data.add(MockData(name, url, response));
    } else {
      widget.mockData?.name = name;
      widget.mockData?.url = url;
      widget.mockData?.response = response;
    }
    widget.mockServer.isAddNew.value = false;
    mockController.updateServer(widget.mockServer);
  }
}
