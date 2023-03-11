import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' as material;
import 'package:get/get.dart';
import 'package:mock_client/controller/mock_controller.dart';
import 'package:mock_client/model/mock_data.dart';
import 'package:mock_client/model/mock_server.dart';
import 'package:mock_client/objectbox.g.dart';
import 'package:mock_client/view/create_server_dialog.dart';
import 'package:mock_client/view/mock_edit_view.dart';
import 'package:window_manager/window_manager.dart';

class NavigationWidget extends StatefulWidget {
  const NavigationWidget({Key? key}) : super(key: key);

  @override
  State<NavigationWidget> createState() => _NavigationWidgetState();
}

class _NavigationWidgetState extends State<NavigationWidget> {
  bool isWindows = defaultTargetPlatform == TargetPlatform.windows;
  MockController mockController = Get.find();
  final index = 0.obs;

  @override
  Widget build(BuildContext context) {
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
                        icon: const Icon(FluentIcons.add, size: 12,),
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
        selected: index.value,
        onChanged: (i) => index.value = i,
        displayMode: PaneDisplayMode.open,

        items: List.generate(mockController.servers.length, (index){
            MockServer server = mockController.servers[index];
            return PaneItemExpander(
                icon: const Icon(FluentIcons.cell_phone),
                title: Text("${server.name}(${server.addr})",),
                infoBadge:ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 40),
                  child: CommandBar(

                    primaryItems: [
                      CommandBarButton(
                        icon: const Icon(FluentIcons.add, size: 12,),
                        label: const Text('New'),
                        onPressed: (){
                          this.index.value = index;
                          Navigator.pop(context);
                        },
                      ),
                      CommandBarButton(
                        icon: const Icon(FluentIcons.delete, size: 12,),
                        label: const Text('Delete'),
                        onPressed: (){
                          mockController.delete(server);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                body: MockEditWidget(server),
                items: List.generate(server.data.length, (index){
                  MockData data = server.data[index];
                    return PaneItem(
                              icon: const Icon(FluentIcons.azure_a_p_i_management),
                              title: Text(data.name),
                              infoBadge: IconButton(icon: const Icon(FluentIcons.delete, size: 12,), onPressed: (){
                                server.data.remove(data);
                                mockController.updateServer(server);
                              },),
                              body: MockEditWidget(server, mockData: data,),
                            );
                  })
            );
          }),

      ),
      transitionBuilder: (child, animation) {
        return SuppressPageTransition(child: child,);
      }
    ));
  }
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
