import 'package:flutter/material.dart';

void snackBarError(String msg, GlobalKey<ScaffoldState> scaffoldState) {
  scaffoldState.currentState?.hideCurrentSnackBar();
  scaffoldState.currentState?.showSnackBar(SnackBar(content: Text(msg)));
}
