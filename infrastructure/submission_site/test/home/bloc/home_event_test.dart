import 'package:flutter_test/flutter_test.dart';
import 'package:submission_site/home/bloc/home_bloc.dart';

void main() {
  group('HomeTimestampChanged', () {
    const int defaultTimestamp = 1647907200;

    test('supports value equality', () {
      expect(
        const HomeTimestampChanged(defaultTimestamp),
        equals(const HomeTimestampChanged(defaultTimestamp)),
      );
    });

    test('props are correct', () {
      expect(
        const HomeTimestampChanged(defaultTimestamp).props,
        equals([defaultTimestamp]),
      );
    });
  });

  group('HomeScoreChanged', () {
    const int defaultScore = 4;

    test('supports value equality', () {
      expect(
        const HomeScoreChanged(defaultScore),
        equals(const HomeScoreChanged(defaultScore)),
      );
    });

    test('props are correct', () {
      expect(
        const HomeScoreChanged(defaultScore).props,
        equals([defaultScore]),
      );
    });
  });

  group('HomeSelectionsChanged', () {
    const List<String> defaultSelections = ['001_01', '002_01', '004_01'];

    test('supports value equality', () {
      expect(
        const HomeSelectionsChanged(defaultSelections),
        equals(const HomeSelectionsChanged(defaultSelections)),
      );
    });

    test('props are correct', () {
      expect(
        const HomeSelectionsChanged(defaultSelections).props,
        equals([defaultSelections]),
      );
    });
  });

  group('HomeSubmissionRequested', () {
    const String defaultId = 'f2f2011c-8d25-4784-9dfc-e99ae4b75797';

    test('supports value equality', () {
      expect(
        const HomeSubmissionRequested(defaultId),
        equals(const HomeSubmissionRequested(defaultId)),
      );
    });

    test('props are correct', () {
      expect(
        const HomeSubmissionRequested(defaultId).props,
        equals([defaultId]),
      );
    });
  });

  group('HomeSurveyRequested', () {
    test('supports value equality', () {
      expect(
        const HomeSurveyRequested(),
        equals(const HomeSurveyRequested()),
      );
    });

    test('props are correct', () {
      expect(
        const HomeSurveyRequested().props,
        equals([]),
      );
    });
  });

  group('HomeChangesReverted', () {
    test('supports value equality', () {
      expect(
        const HomeChangesReverted(),
        equals(const HomeChangesReverted()),
      );
    });

    test('props are correct', () {
      expect(
        const HomeChangesReverted().props,
        equals([]),
      );
    });
  });

  group('HomeChangesSubmitted', () {
    test('supports value equality', () {
      expect(
        const HomeChangesSubmitted(),
        equals(const HomeChangesSubmitted()),
      );
    });

    test('props are correct', () {
      expect(
        const HomeChangesSubmitted().props,
        equals([]),
      );
    });
  });
}
