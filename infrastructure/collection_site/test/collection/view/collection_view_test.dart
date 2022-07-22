import 'package:collection_site/collection_site.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCollectionApiRepository<T> extends Mock
    implements CollectionApiRepository<T> {}

class MockCollectionRoute extends CollectionRoute<String> {
  const MockCollectionRoute({
    Key? key,
    required CollectionApiRepository<String> repository,
  }) : super(
          key: key,
          repository: repository,
          initialMessage: 'initial message',
          emptyCollectionMessage: 'empty collection message',
          errorMessage: 'error message',
        );

  @override
  Widget display(String item) {
    return Text(item);
  }
}

void main() {
  late CollectionApiRepository<String> repository;

  group('CollectionRoute', () {
    setUp(() {
      repository = MockCollectionApiRepository<String>();
    });

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MockCollectionRoute(repository: repository),
        ),
      ));
      await tester.pumpAndSettle();
    }

    group('renders', () {
      testWidgets('CollectionView', (tester) async {
        await pumpApp(tester);
        expect(find.byType(CollectionView<String>), findsOneWidget);
      });
    });

    testWidgets('fetches collection on initialization', (tester) async {
      await pumpApp(tester);
      verify(() => repository.fetchCollection({})).called(1);
    });
  });

  group('CollectionView', () {
    const initialMessage = 'initial message';
    const emptyCollectionMessage = 'empty collection message';
    const errorMessage = 'error message';

    Widget itemToWidget(String item) {
      return Text(item);
    }

    final collectionView = CollectionView<String>(
      initialMessage: initialMessage,
      emptyCollectionMessage: emptyCollectionMessage,
      errorMessage: errorMessage,
      itemToWidget: itemToWidget,
    );

    late CollectionBloc<String> bloc;

    setUp(() {
      repository = MockCollectionApiRepository<String>();
      bloc = CollectionBloc<String>(repository: repository);
    });

    Future<void> pumpApp(WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: RepositoryProvider.value(
            value: repository,
            child: BlocProvider.value(
              value: bloc,
              child: collectionView,
            ),
          ),
        ),
      ));
    }

    group('renders', () {
      testWidgets('contentFromState', (tester) async {
        await pumpApp(tester);

        // There should always be a center widget, no matter what.
        expect(find.byType(Center), findsOneWidget);

        /* 
        There should be exactly one of the following:
          * a Text (if status is CollectionInitial or CollectionFailure)
          * a CircularProgressIndicator (if status is CollectionInProgress)
          * a Scrollbar (if status is CollectionSuccess)
        */
        Finder findProgressIndicators = find.descendant(
          of: find.byType(Center),
          matching: find.byType(CircularProgressIndicator),
        );
        Finder findScrollbars = find.descendant(
          of: find.byType(Center),
          matching: find.byType(Scrollbar),
        );
        Finder findTexts = find.descendant(
          of: find.byType(Center),
          matching: find.byType(Text),
        );

        int numProgressIndicators = findProgressIndicators.evaluate().length;
        int numScrollbars = findScrollbars.evaluate().length;
        int numTexts = findTexts.evaluate().length;

        bool isInitialOrFailure =
            numProgressIndicators == 0 && numScrollbars == 0 && numTexts == 1;
        bool isInProgress =
            numProgressIndicators == 1 && numScrollbars == 0 && numTexts == 0;
        bool isSuccess = numProgressIndicators == 0 && numScrollbars == 1;

        expect(isInProgress || isSuccess || isInitialOrFailure, isTrue);
      });
    });

    group('contentFromState', () {
      Future<void> pumpApp(
        WidgetTester tester,
        CollectionState<String> state,
      ) async {
        await tester.pumpWidget(MaterialApp(
          home: Column(
            children: [collectionView.contentFromState(state)],
          ),
        ));
      }

      testWidgets(
        'returns initial message when status is CollectionInitial',
        (tester) async {
          await pumpApp(tester, const CollectionInitial());
          expect(find.text(initialMessage), findsOneWidget);
        },
      );

      testWidgets(
        'returns progress indicator when status is CollectionInProgress',
        (tester) async {
          await pumpApp(tester, const CollectionInProgress());
          expect(find.byType(CircularProgressIndicator), findsOneWidget);
        },
      );

      testWidgets(
        'returns list of items in collection when status is CollectionSuccess',
        (tester) async {
          const collection = ['first', 'second', 'third'];
          await pumpApp(
            tester,
            const CollectionSuccess(collection),
          );
          Widget collectionDisplay =
              collectionView.displayCollection(collection);

          /*
          Verify that the collection display is either a Text or a scroll view
          */
          expect(
              collectionDisplay.runtimeType == Text ||
                  collectionDisplay.runtimeType == SingleChildScrollView,
              isTrue);

          /*
          If the collection display is a Text, verify that a Text with matching 
          data is returned
          */
          if (collectionDisplay.runtimeType == Text) {
            String? data = (collectionDisplay as Text).data;
            expect(data, isNotNull);
            expect(find.text(data!), findsOneWidget);
          }
          /*
          If the collection display is a scroll view, verify that a scroll view 
          is returned
          */
          else if (collectionDisplay.runtimeType == SingleChildScrollView) {
            expect(find.byType(SingleChildScrollView), findsOneWidget);
          }
        },
      );

      testWidgets(
        'returns error message if status is CollectionFailure',
        (tester) async {
          await pumpApp(tester, const CollectionFailure());
          expect(find.text(errorMessage), findsOneWidget);
        },
      );
    });

    group('displayCollection', () {
      test('returns correct Text if collection is empty', () {
        final collectionDisplay = collectionView.displayCollection([]);
        expect(collectionDisplay.runtimeType, equals(Text));
        expect(
          (collectionDisplay as Text).data,
          equals(emptyCollectionMessage),
        );
      });

      testWidgets(
        'returns ListView with all collection items if collection is not empty',
        (tester) async {
          const collection = ['item1', 'item2', 'item3'];

          // Render collection display
          await tester.pumpWidget(MaterialApp(
            home: Scaffold(
              body: collectionView.displayCollection(collection),
            ),
          ));

          // Verify that the collection display is a scroll view
          expect(find.byType(SingleChildScrollView), findsOneWidget);

          // Verify that the scroll view contains a ListView
          expect(find.byType(ListView), findsOneWidget);

          // Verify that all items are displayed
          for (String item in collection) {
            expect(find.text(item), findsOneWidget);
          }
        },
      );
    });
  });
}
