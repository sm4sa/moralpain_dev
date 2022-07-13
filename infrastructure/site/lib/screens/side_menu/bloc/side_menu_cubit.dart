import 'package:bloc/bloc.dart';

enum DashboardView { SUBMISSIONS, ANALYTICS }

class SideMenuCubit extends Cubit<DashboardView> {
  SideMenuCubit() : super(DashboardView.SUBMISSIONS);

  void setView(DashboardView view) => emit(view);
}
