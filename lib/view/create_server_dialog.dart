
import 'package:fluent_ui/fluent_ui.dart';

void showContentDialog(BuildContext context) async {
  final result = await showDialog<String>(
    context: context,
    builder: (context) => ContentDialog(
      title: const Text('创建服务'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('名称:'),
              SizedBox(width: 10),
              Container(
                width: 250,
                child: TextBox(
                  placeholder: "请输入名称",
                ),
              )
            ],
          ),
          const SizedBox(height: 20,),
          Row(
            children:  [
              Text('地址:'),
              SizedBox(width: 10),
              Container(
                width: 250,
                child: TextBox(
                  placeholder: "192.168.1.8:8080",
                ),
              )
            ],
          ),
        ],
      ),
      actions: [
        Button(
          child: const Text('取消'),
          onPressed: () =>  Navigator.pop(context),
        ),
        FilledButton(
          child: const Text('确定'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}