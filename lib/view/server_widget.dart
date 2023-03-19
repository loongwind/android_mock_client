import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:mock_client/controller/mock_controller.dart';
import 'package:mock_client/model/mock_data.dart';
import 'package:mock_client/model/mock_server.dart';
import 'package:mock_client/view/create_server_dialog.dart';
import 'package:mock_client/view/delete_dialog.dart';

class ServerWidget extends StatefulWidget {
  final MockServer server;

  const ServerWidget(this.server, {Key? key}) : super(key: key);

  @override
  State<ServerWidget> createState() => _ServerWidgetState();
}

class _ServerWidgetState extends State<ServerWidget> {
  MockController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        buildServerInfo(),
        buildMockData(),
      ],
    );
  }

  Widget buildServerInfo() {
    return Row(
      children: [
        const SizedBox(
          width: 30,
        ),
        Text("名称：${widget.server.name}"),
        const SizedBox(
          width: 30,
        ),
        Text("地址：${widget.server.addr}"),
        const SizedBox(
          width: 30,
        ),
        IconButton(
            icon: Icon(
              FluentIcons.refresh,
              color: material.Theme.of(context).primaryColor,
            ),
            onPressed: () => controller.refreshMockData(widget.server)),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            icon: Icon(
              FluentIcons.edit,
              color: material.Theme.of(context).primaryColor,
            ),
            onPressed: () => showContentDialog(context, server: widget.server)),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            icon: Icon(
              FluentIcons.delete,
              color: material.Theme.of(context).colorScheme.error,
            ),
            onPressed: () {
              showDeleteDialog(context: context, msg: widget.server.name, confirmDelete: (){
                  controller.delete(widget.server);
              });

            }),
        const SizedBox(
          width: 10,
        ),
        IconButton(
            icon: Icon(
              FluentIcons.add,
              color: material.Theme.of(context).indicatorColor,
            ),
            onPressed: () {
              widget.server.isAddNew.value = true;
            }),
        const SizedBox(
          width: 10,
        ),
        Obx(()=>ToggleSwitch(
            checked: widget.server.isMocking.value,
            onChanged: (bool value) {
              controller.changeMockState(widget.server, value);
            },
          ),
        ),
        const SizedBox(
          width: 30,
        )
      ],
    );
  }

  Widget buildMockData() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
            decoration: BoxDecoration(
                border:
                    Border.all(color: material.Theme.of(context).dividerColor),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: widget.server.data.length,
              itemBuilder: (context, index) {
                MockData mockData = widget.server.data[index];
                return ListTile.selectable(
                  onPressed: () => controller.selectedIndex.value = mockData.sort,
                  leading: Padding(
                    padding: const EdgeInsets.symmetric(vertical:10),
                      child: Icon(FluentIcons.azure_a_p_i_management, color: mockData.isActive.value && widget.server.isMocking.value ? Colors.blue : null,)),
                  title: Text(mockData.name),
                  subtitle: Text(mockData.url),
                  trailing: Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            FluentIcons.edit,
                            color: material.Theme.of(context).primaryColor,
                          ),
                          onPressed: () =>controller.selectedIndex.value = mockData.sort,
                      ),
                      IconButton(
                          icon: Icon(FluentIcons.delete,
                              color:
                                  material.Theme.of(context).colorScheme.error),
                          onPressed: () {
                            showDeleteDialog(context: context, msg: mockData.name, confirmDelete: (){
                                controller.removeMockData(widget.server, mockData);
                            });

                          })
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  size: 1,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
