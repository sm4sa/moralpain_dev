import 'package:submissions_site/models/RecentReport.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'view_report_state.dart';

class ViewReportCubit extends Cubit<ViewReportState> {
  ViewReportCubit({required RecentReport? fileInfo})
      : super(ViewReportState(fileInfo: fileInfo));
}
