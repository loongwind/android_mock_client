import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:mock_client/controller/mock_controller.dart';
import 'package:mock_client/model/mock_server.dart';
import 'package:mock_client/view/create_server_dialog.dart';
import 'package:window_manager/window_manager.dart';

Widget buildNavigationView(
    BuildContext context, int topIndex, Function(int) callback) {
  bool isWindows = defaultTargetPlatform == TargetPlatform.windows;
  MockController mockController = Get.find();
  return Obx(() => NavigationView(
    appBar: NavigationAppBar(
        leading: Container(),
        title: () {
          return DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.center,
              child: Text(
                "Android Mock Client",
                style: material.Theme.of(context).textTheme.titleMedium,
              ),
            ),
          );
        }(),
      actions: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Padding(
              padding: EdgeInsets.only(left: isWindows ? 10 : 250),
              child: CommandBar(
                primaryItems: [
                  CommandBarButton(
                    icon: const Icon(FluentIcons.add),
                    label: const Text('New'),
                    onPressed: () => showContentDialog(context),
                  ),
                ],
              ),
            ),
          ),
          // WindowButtons()
          if(isWindows) WindowButtons() else Container()
        ],
      )
        // actions: defaultTargetPlatform == TargetPlatform.windows
        //     ? const WindowButtons()
        //     : null
    ),
    pane: NavigationPane(
      selected: topIndex,
      onChanged: callback,
      displayMode: PaneDisplayMode.open,
      items: [
        ...List.generate(mockController.servers.length, (index){
          MockServer server = mockController.servers[index];
          return PaneItemExpander(
            icon: const Icon(FluentIcons.cell_phone),
            title: Text("${server.name}(${server.addr})",),

            body: Container(),
            items: []
          );
        }),
        // PaneItemExpander(
        //   icon: const Icon(FluentIcons.cell_phone),
        //   title: const Text('Account'),
        //   body: Container(),
        //   items: [
        //     PaneItem(
        //       icon: const Icon(FluentIcons.azure_a_p_i_management),
        //       title: const Text('Mail'),
        //       body: Container(),
        //     ),
        //     PaneItem(
        //       icon: const Icon(FluentIcons.azure_a_p_i_management),
        //       title: const Text('Calendar'),
        //       body: Container(),
        //     ),
        //   ],
        // ),
      ],
    ),
  ));
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
