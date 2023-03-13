
import 'package:mock_client/http/exception.dart';
import 'package:mock_client/http/exception_handler.dart';
import 'package:mock_client/view/loading.dart';

Future request(
  Function() block, {
  bool showLoading = true,
  bool Function(ApiException)? onError,
}) async {
  try {
    await loading(block, isShowLoading: showLoading);
  } catch (e) {
    handleException(ApiException.from(e), onError: onError);
  }
  return;
}
