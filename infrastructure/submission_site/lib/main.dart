import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submission_site/constants.dart';
import 'package:submission_site/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final builder = SubmissionBuilder();
    builder.id = '119ada26-a0ba-4991-82f4-d6aa7c73c503';
    builder.score = 4;
    builder.timestamp = 1658944322;
    builder.selections = ListBuilder(['001_01', '001_02', '001_03', '001_04']);

    return MaterialApp(
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: HomeRoute(builder.build()),
    );
  }
}
