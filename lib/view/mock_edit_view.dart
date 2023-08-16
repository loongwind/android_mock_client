import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:json_editor/json_editor.dart';
import 'package:mock_client/controller/mock_controller.dart';
import 'package:mock_client/model/mock_data.dart';
import 'package:mock_client/model/mock_server.dart';
import 'package:mock_client/utils/base64.dart';

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
  JsonElement? _elementResult;
  bool isJsonMode = false;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.mockData?.name ?? "";
    urlController.text = widget.mockData?.url ?? "";
    responseController.text = widget.mockData?.response.decodeBase64() ?? "";
    isJsonMode = widget.mockData?.isJsonMode ?? false;
    try {
        _elementResult = JsonElement.fromString(widget.mockData?.response.decodeBase64() ?? "");
    } catch (e) {
      print(e);
    }
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
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: Text('Response:'),
              ),
              const SizedBox(width: 20,),
              RadioButton(
                checked: !isJsonMode,
                content: const Text('Text'),
                onChanged: (value){
                  setState(() {
                    isJsonMode = false;
                  });
                },
              ),
              const SizedBox(width: 20,),
              RadioButton(
                checked: isJsonMode,
                content: const Text('Json'),
                onChanged: (value){
                  setState(() {
                    isJsonMode = true;
                  });
                },
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 30),
                  child: isJsonMode ? FilledButton(
                    onPressed: (){
                      setState(() {

                      });
                    },

                    child: const Text('格式化',),
                  ) : Container(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            // padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: isJsonMode ? material.Material(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey[30]),
                    borderRadius: BorderRadius.circular(5)
                  ),
                  padding: const EdgeInsets.all(10),
                  child: JsonEditor.object(
                    object: _elementResult?.toObject(),
                    onValueChanged: (value){
                      _elementResult = value;
                    },
                  ),
                ),
              ) : TextBox(
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
    bool showToggle = widget.mockData != null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 30),
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: showToggle ? Obx(() => ToggleSwitch(
            checked: widget.mockData?.enabledObs.value ?? false,
            onChanged: (bool value) {
              mockController.changeMockDataState(widget.mockServer, widget.mockData!, value);
            },
          ),) : Container(),
        ),
        Container(
          padding: const EdgeInsets.only(right: 30),
          margin: const EdgeInsets.only(top: 20, bottom: 20),
          child: FilledButton(
            onPressed: submit,
            child: const Text('提交'),
          ),
        ),
      ],
    );
  }

  void submit() {
    String name = nameController.text;
    String url = urlController.text;
    String response = isJsonMode ? _elementResult.toString().toBase64() : responseController.text.toBase64();

    if (widget.mockData == null) {
      var mockData = MockData(name, url, response, isJsonMode: isJsonMode);
      mockData.isNew = true;
      widget.mockServer.data.add(mockData);
      mockController.updateServer(widget.mockServer);
    } else {
      widget.mockData?.name = name;
      widget.mockData?.url = url;
      widget.mockData?.response = response;
      widget.mockData?.isJsonMode = isJsonMode;
      mockController.updateMockData(widget.mockServer, widget.mockData!);
    }
    widget.mockServer.isAddNew.value = false;
  }
}
