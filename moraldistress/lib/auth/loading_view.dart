import 'package:flutter/material.dart';
import 'package:uva_themed_widgets/uva_themed_widgets.dart';

class LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: UVACircularProgressIndicator(),
      ),
    );
  }
}
