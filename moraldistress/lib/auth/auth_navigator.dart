import 'package:moraldistress/auth/auth_cubit.dart';
import 'package:moraldistress/auth/auth_state.dart';
import 'package:moraldistress/auth/auth_view.dart';
import 'package:moraldistress/home/home.dart';
import 'package:moraldistress/auth/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      print(state);
      return Navigator(
        pages: [
          if (state is Unauthenticated) MaterialPage(child: AuthView()),
          if (state is Authenticated) MaterialPage(child: HomeRoute()),
          if (state is UnknownAuthState) MaterialPage(child: LoadingView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
