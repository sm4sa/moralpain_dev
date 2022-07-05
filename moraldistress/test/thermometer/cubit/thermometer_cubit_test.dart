import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moraldistress/thermometer/cubit/thermometer_cubit.dart';

void main() {
  group('ThermometerCubit', () {
    ThermometerCubit buildCubit() => ThermometerCubit();

    group('constructor', () {
      test('works properly', () {
        expect(buildCubit, returnsNormally);
      });

      test('has correct initial state', () {
        expect(buildCubit().state, equals(0));
      });
    });

    group('set', () {
      blocTest<ThermometerCubit, double>(
        'sets state to given value',
        build: buildCubit,
        act: (cubit) => cubit.set(7.0522),
        expect: () => [7.0522],
      );
    });
  });
}
