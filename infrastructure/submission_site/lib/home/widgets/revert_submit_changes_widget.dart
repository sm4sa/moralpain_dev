import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:submission_site/home/home.dart';

class RevertSubmitChangesWidget extends StatelessWidget {
  final bool enabled;

  const RevertSubmitChangesWidget({
    Key? key,
    required this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeBloc bloc = BlocProvider.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: enabled ? revertChangesDialog(context, bloc) : null,
          child: const Text('Revert Changes'),
        ),
        const SizedBox(width: 30.0),
        ElevatedButton(
          onPressed: enabled ? submitChangesDialog(context, bloc) : null,
          child: const Text('Submit Changes'),
        ),
        const SizedBox(height: 50.0)
      ],
    );
  }

  @visibleForTesting
  static Function() revertChangesDialog(
    BuildContext context,
    HomeBloc bloc,
  ) {
    return () {
      final alert = AlertDialog(
        title: const Text(
          'Are you sure you want to revert your changes?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              bloc.add(
                const HomeChangesReverted(),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          )
        ],
      );
      showDialog(context: context, builder: (_) => alert);
    };
  }

  @visibleForTesting
  static Function() submitChangesDialog(BuildContext context, HomeBloc bloc) {
    return () {
      final alert = AlertDialog(
        title: const Text(
          'Are you sure you want to submit your changes?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () async {
              bloc.add(
                const HomeChangesSubmitted(),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          )
        ],
      );
      showDialog(context: context, builder: (_) => alert);
    };
  }
}
