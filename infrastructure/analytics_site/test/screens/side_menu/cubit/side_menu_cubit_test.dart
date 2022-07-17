import 'package:analytics_site/screens/side_menu/side_menu.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SideMenuCubit', () {
    SideMenuCubit buildCubit() {
      return SideMenuCubit();
    }

    group('constructor', () {
      test('completes normally', () {
        expect(buildCubit, returnsNormally);
      });

      test('has correct initial state', () {
        expect(buildCubit().state, equals(DashboardView.SUBMISSIONS));
      });
    });

    group('setView', () {
      blocTest<SideMenuCubit, DashboardView>(
        'changes state to given DashboardView',
        build: buildCubit,
        act: (cubit) => cubit.setView(DashboardView.ANALYTICS),
        expect: () => [DashboardView.ANALYTICS],
      );
    });
  });

  group('DashboardView', () {
    test('supports value equality', () {
      expect(DashboardView.SUBMISSIONS, equals(DashboardView.SUBMISSIONS));
      expect(DashboardView.ANALYTICS, equals(DashboardView.ANALYTICS));
    });
  });
}
