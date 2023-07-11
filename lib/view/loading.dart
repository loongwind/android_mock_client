
import 'package:fluent_ui/fluent_ui.dart';
import 'package:mock_client/main.dart';

String _loadingText = "loading";
String? _loadingResult = "";

int _showLoadingFlag = 0;

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
  if(_showLoadingFlag > 0){
    _showLoadingFlag ++;
    return;
  }
  _showLoadingFlag ++;
  final context = navigatorKey.currentState?.overlay?.context;
  if(context != null){
    _loadingResult = _loadingText;
    _loadingResult = await showDialog<String>(
      context: (navigatorKey.currentState?.overlay?.context)!,
      builder: (context) => const Center(child: ProgressRing()),
    );
  }
}

void dismissLoading() {
  _showLoadingFlag --;
  if(_showLoadingFlag > 0){
    return;
  }
  _showLoadingFlag = 0;
  if(_loadingResult == _loadingText){
    _loadingResult = "";
    Navigator.pop((navigatorKey.currentState?.overlay?.context)!);
  }
}
