import 'package:flutter/material.dart';

class MessageDialog {
  static AlertDialog getAlertDialog(context, String message) =>
      AlertDialog(content: Text(message), actions: <Widget>[
        TextButton(
            child: const Text('Yes'),
            onPressed: () => Navigator.of(context).pop(true)),
        TextButton(
            child: const Text('No'),
            onPressed: () => Navigator.of(context).pop(false)),
      ]);
}
