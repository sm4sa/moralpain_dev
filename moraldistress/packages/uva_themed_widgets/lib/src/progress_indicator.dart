import 'package:flutter/material.dart';
import 'package:uva_themed_widgets/src/colors.dart' as uvacolors;

class UVACircularProgressIndicator extends CircularProgressIndicator {
  @override
  Color? get backgroundColor => uvacolors.UVABlue;

  @override
  Animation<Color?>? get valueColor =>
      AlwaysStoppedAnimation(uvacolors.UVAOrange);
}

class UVALinearProgressIndicator extends LinearProgressIndicator {
  @override
  double? get minHeight => 10;

  @override
  Animation<Color?>? get valueColor =>
      AlwaysStoppedAnimation(uvacolors.UVAOrange);
}
