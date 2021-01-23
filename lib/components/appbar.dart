import 'package:feedall/app_localizations.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

Widget FeeadAllAppBar(var context, String title) {
  return AppBar(
    title: Text(
      AppLocalizations.of(context).translate(title),
    ),
    backgroundColor: dark,
  );
}
