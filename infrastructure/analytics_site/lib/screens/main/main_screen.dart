import 'package:analytics_site/controllers/MenuController.dart';
import 'package:analytics_site/responsive.dart';
import 'package:analytics_site/screens/dashboard/dashboard_screen.dart';
import 'package:analytics_site/screens/side_menu/side_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static Route route() => MaterialPageRoute<void>(
        builder: (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuController(),
            ),
          ],
          child: MainScreen(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: BlocProvider<SideMenuCubit>(
        create: (_) => SideMenuCubit(),
        child: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // We want this side menu only for large screen
              if (Responsive.isDesktop(context))
                Expanded(
                  // default flex = 1
                  // and it takes 1/6 part of the screen
                  child: SideMenu(),
                ),
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: DashboardScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
