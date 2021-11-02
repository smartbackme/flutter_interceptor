import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///复制到粘贴板
copyClipboard(BuildContext context, String? value) {
  var snackBar = SnackBar(content: Text('copy $value to clipboard'));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
  Clipboard.setData(ClipboardData(text: value));
}
