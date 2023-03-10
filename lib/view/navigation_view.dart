import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:window_manager/window_manager.dart';

Widget buildNavigationView(int topIndex, Function(int) callback) {
  return NavigationView
    (
    appBar: NavigationAppBar(
      leading: Container(),
      actions: defaultTargetPlatform == TargetPlatform.windows ? const WindowButtons() : null
    ),
    pane: NavigationPane(
      selected: topIndex,
      onChanged: callback,
      displayMode: PaneDisplayMode.open,
      items: [
        PaneItemExpander(
          icon: const Icon(FluentIcons.cell_phone),
          title: const Text('Account'),
          body: Container(),
          items: [
            PaneItem(
              icon: const Icon(FluentIcons.azure_a_p_i_management),
              title: const Text('Mail'),
              body: Container(),
            ),
            PaneItem(
              icon: const Icon(FluentIcons.azure_a_p_i_management),
              title: const Text('Calendar'),
              body: Container(),
            ),
          ],
        ),
      ],
    ),
  );
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