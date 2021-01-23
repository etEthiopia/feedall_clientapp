import 'package:feedall/app_localizations.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

void showSucess(String message, var context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text(
      AppLocalizations.of(context).translate(message),
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: primary,
  ));
}
