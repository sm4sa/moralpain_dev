import 'package:submissions_site/models/RecentReport.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:submissions_site/screens/view_report/view_report.dart';

class ViewReportPage extends StatelessWidget {
  const ViewReportPage({Key? key}) : super(key: key);

  static Route<void> route({RecentReport? fileInfo}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => ViewReportCubit(fileInfo: fileInfo),
        child: ViewReportPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ViewReportCubit, ViewReportState>(
      listener: (context, state) => Navigator.of(context).pop(),
      child: const ViewReportView(),
    );
  }
}

class ViewReportView extends StatelessWidget {
  const ViewReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fileInfo =
        context.select((ViewReportCubit cubit) => cubit.state.fileInfo);

    if (fileInfo == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('No report to view.'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(fileInfo.title ?? 'No title for this report.'),
        ),
        body: Center(
          child: Text(fileInfo.date ?? 'No date for this report.'),
        ),
      );
    }
  }
}
