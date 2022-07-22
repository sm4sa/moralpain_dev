import 'package:collection_site/collection_site.dart';
import 'package:flutter/material.dart';
import 'package:moralpainapi/moralpainapi.dart';
import 'package:submissions_site/submissions/submissions.dart';

class SubmissionsRoute extends CollectionRoute<Submission> {
  const SubmissionsRoute({
    Key? key,
    required CollectionApiRepository<Submission> repository,
  }) : super(
          key: key,
          repository: repository,
          initialMessage: 'List of submissions hasn\'t started loading yet.',
          emptyCollectionMessage: 'There are no submissions.',
          errorMessage: 'Error fetching submissions.',
        );

  @override
  Widget display(Submission item) {
    return SubmissionListTile(item);
  }
}
