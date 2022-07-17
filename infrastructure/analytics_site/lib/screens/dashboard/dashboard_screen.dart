import 'package:analytics_site/api_repository.dart';
import 'package:analytics_site/screens/analytics0/analytics.dart';
import 'package:analytics_site/screens/side_menu/side_menu.dart';
import 'package:analytics_site/screens/submissions/view/view.dart';
import 'package:analytics_site/constants.dart';
import 'package:analytics_site/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header(),
            SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      SizedBox(height: defaultPadding),
                      BlocBuilder<SideMenuCubit, DashboardView>(
                        builder: (context, state) {
                          ApiRepository repository = ApiRepository();
                          switch (state) {
                            case DashboardView.SUBMISSIONS:
                              return SubmissionsRoute(repository: repository);
                            case DashboardView.ANALYTICS:
                              return AnalyticsRoute(repository: repository);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
