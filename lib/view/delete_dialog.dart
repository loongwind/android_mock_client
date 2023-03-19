
import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';
import 'package:mock_client/controller/mock_controller.dart';
import 'package:mock_client/model/mock_server.dart';

void showDeleteDialog({required BuildContext context, String? msg, Function()? confirmDelete, Function()? cancelDelete}) async {
  await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      title: const Text('提示'),
      content: Text('是否确认删除${msg == null ? "" : ":$msg"}'),
      actions: [
        Button(
          child: const Text('取消'),
          onPressed: () {
            Navigator.pop(context);
            cancelDelete?.call();
          },
        ),
        FilledButton(
          child: const Text('确定'),
          onPressed: (){
            Navigator.pop(context);
            confirmDelete?.call();
          },
        ),
      ],
    ),
  );
}