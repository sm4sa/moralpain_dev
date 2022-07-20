import 'package:flutter/material.dart';

import 'home/home.dart';
import 'package:moraldistress/assets/colors.dart' as uvacolors;

class MoralDistressApp extends StatelessWidget {
  const MoralDistressApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'LibreFranklin',
          primarySwatch: uvacolors.UVABlue,
        ),
        home: HomeRoute());
  }
}
