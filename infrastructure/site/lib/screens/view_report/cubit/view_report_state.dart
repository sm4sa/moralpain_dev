part of 'view_report_cubit.dart';

class ViewReportState extends Equatable {
  const ViewReportState({this.fileInfo});

  final RecentReport? fileInfo;

  @override
  // TODO: implement props
  List<Object?> get props => [fileInfo];
}
