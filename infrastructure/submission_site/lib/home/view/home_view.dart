import 'package:flutter/material.dart';
import 'package:moralpainapi/moralpainapi.dart' show Submission;
import 'package:submission_site/home/home.dart';
import 'package:submission_site/score/view/score_view.dart';

class SubmissionView extends StatelessWidget {
  final Submission submission;

  const SubmissionView(this.submission, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Submission ID ${submission.id}')),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FieldDisplay(
              text:
                  'Time submitted: ${submission.timestamp != null ? DateTime.fromMillisecondsSinceEpoch(
                      submission.timestamp! * 1000,
                    ).toString() : 'null'}',
              onPressed: () {},
            ),
            FieldDisplay(
              text: 'Score: ${submission.score} out of 10',
              onPressed: () {
                print('Score edit button pressed');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ScoreView(),
                    fullscreenDialog: true,
                  ),
                );
              },
            ),
            FieldDisplay(
              text: 'Contributing factors: ${submission.selections}',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
