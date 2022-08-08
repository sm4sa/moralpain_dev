import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:submission_site/datetime/datetime.dart';
import 'package:submission_site/home/home.dart';

class MockHomeBloc extends Mock implements HomeBloc {}

void main() {
  group('DatetimeRoute', () {
    late HomeBloc homeBloc;

    setUp(() {
      const HomeState homeState = HomeState(timestamp: 1657036800);
      homeBloc = MockHomeBloc();
      when(() => homeBloc.state).thenReturn(homeState);
      when(() => homeBloc.stream).thenAnswer((_) => Stream.value(homeState));
    });

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: BlocProvider<HomeBloc>.value(
            value: homeBloc,
            child: const DatetimeRoute(),
          ),
        ),
      ));
    }

    testWidgets('renders DatetimeView', (tester) async {
      await pumpApp(tester);
      expect(find.byType(DatetimeView), findsOneWidget);
    });
  });
}
