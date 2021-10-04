import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension BC on BuildContext {
  void makeSnackbar(String msg) {
    ScaffoldMessenger.of(this).hideCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(msg)));
  }
}
