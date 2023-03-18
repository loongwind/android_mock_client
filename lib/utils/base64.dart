// base64库
import 'dart:convert' as convert;
import 'dart:core';
// 文件相关

extension StringExtension on String{
  String toBase64(){
    var content = convert.utf8.encode(this);
    var digest = convert.base64Encode(content);
    return digest;
  }

  String decodeBase64(){
    List<int> bytes = convert.base64Decode(this);
    String result = convert.utf8.decode(bytes);
    return result;
  }
}
