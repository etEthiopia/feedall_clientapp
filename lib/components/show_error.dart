import 'package:feedall/app_localizations.dart';
import 'package:flutter/material.dart';

void showError(String message, var context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      AppLocalizations.of(context).translate(message),
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Colors.red,
  ));
}
