import 'package:submissions_site/api_repository.dart';
import 'package:submissions_site/screens/submissions/view/view.dart';
import 'package:submissions_site/constants.dart';
import 'package:submissions_site/screens/dashboard/components/header.dart';
import 'package:flutter/material.dart';

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
                      SubmissionsRoute(repository: ApiRepository()),
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
