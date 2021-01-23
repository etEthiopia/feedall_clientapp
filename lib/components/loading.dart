import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:feedall/theme/theme_colors.dart';
import 'package:flutter/material.dart';

Loading(context) {
  return SpinKitFadingCube(
    size: 100,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? primary : dark,
        ),
      );
    },
  );
}
