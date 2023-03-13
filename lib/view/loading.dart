
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mock_client/main.dart';

String _loadingText = "loading";
String? _loadingResult = _loadingText;

Future loading(Function block, {bool isShowLoading = true}) async {
  if (isShowLoading) {
    showLoading();
  }
  try {
    await block();
  } catch (e) {
    rethrow;
  } finally {
    dismissLoading();
  }
  return;
}

void showLoading() async{
  _loadingResult = _loadingText;
  _loadingResult = await showDialog<String>(
    context: (navigatorKey.currentState?.overlay?.context)!,
    builder: (context) => const Center(child: ProgressRing()),
  );
}

void dismissLoading() {
  if(_loadingResult == _loadingText){
    Navigator.pop((navigatorKey.currentState?.overlay?.context)!);
  }
}
