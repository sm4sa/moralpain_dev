import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:moraldistress/app.dart';
import 'package:moraldistress/home/home.dart';
import 'package:moraldistress/assets/colors.dart' as uvacolors;

import 'amplifyconfiguration.dart';

class AuthWrappedApp extends StatefulWidget {
  const AuthWrappedApp({Key? key}) : super(key: key);

  @override
  State<AuthWrappedApp> createState() => _AuthWrappedAppState();
}

class _AuthWrappedAppState extends State<AuthWrappedApp> {
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    try {
      await Amplify.addPlugin(AmplifyAuthCognito());
      await Amplify.configure(amplifyconfig);
      print('Successfully configured');
    } on Exception catch (e) {
      print('Error configuring Amplify: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Authenticator(
      child: MaterialApp(
          theme: ThemeData(
            fontFamily: 'LibreFranklin',
            primarySwatch: uvacolors.UVABlue,
          ),
          builder: Authenticator.builder(),
          home: HomeRoute()),
    );
  }
}
