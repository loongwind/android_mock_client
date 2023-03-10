import 'package:fluent_ui/fluent_ui.dart';

Widget buildNavigationView(int topIndex, Function(int) callback) {
  return NavigationView
    (
    appBar: const NavigationAppBar(
      // title: Text('NavigationView'),
      leading: Text("")
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