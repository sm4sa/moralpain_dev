import 'package:flutter/material.dart';

import 'home/home.dart';

/// {@template counter_app}
/// A [MaterialApp] which sets the `home` to [CounterPage].
/// {@endtemplate}
class MoralDistressApp extends MaterialApp {
  @override
  ThemeData? get theme => ThemeData(fontFamily: 'LibreFranklin');

  const MoralDistressApp({Key? key}) : super(key: key, home: const HomeRoute());
}
