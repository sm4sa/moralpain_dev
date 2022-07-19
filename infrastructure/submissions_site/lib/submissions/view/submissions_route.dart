import 'package:submissions_site/api_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../submissions.dart';

class SubmissionsRoute extends StatelessWidget {
  final ApiRepository repository;

  const SubmissionsRoute({Key? key, required this.repository})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: repository,
      child: BlocProvider(
        create: (_) => SubmissionsBloc(repository: repository)
          ..add(SubmissionsLoadEvent()),
        child: SubmissionsView(),
      ),
    );
  }
}
