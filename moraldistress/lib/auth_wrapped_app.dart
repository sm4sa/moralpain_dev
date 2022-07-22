import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_authenticator/amplify_authenticator.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moraldistress/app.dart';
import 'package:moraldistress/home/home.dart';
import 'package:moraldistress/auth/app_navigator.dart';
import 'package:moraldistress/auth/loading_view.dart';
import 'package:moraldistress/assets/colors.dart' as uvacolors;

import 'amplifyconfiguration.dart';
import 'auth/auth_cubit.dart';

class AuthWrappedApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthWrappedAppState();
}

class _AuthWrappedAppState extends State<AuthWrappedApp> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'LibreFranklin',
        primarySwatch: uvacolors.UVABlue,
      ),
      home: BlocProvider(
        create: (context) => AuthCubit()..attemptAutoSignIn(),
        child: _amplifyConfigured ? AppNavigator() : LoadingView(),
      ),
    );
  }

  void _configureAmplify() async {
    try {
      await Future.wait([Amplify.addPlugin(AmplifyAuthCognito())]);
      await Amplify.configure(amplifyconfig);
      setState(() => _amplifyConfigured = true);
    } catch (e) {
      print(e);
    }
  }
}
