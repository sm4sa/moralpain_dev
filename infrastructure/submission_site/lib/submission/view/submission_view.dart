import 'package:flutter/material.dart';
import 'package:moralpainapi/moralpainapi.dart' show Submission;

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
            ),
            FieldDisplay(
              text: 'Score: ${submission.score} out of 10',
            ),
            FieldDisplay(
              text: 'Contributing factors: ${submission.selections}',
            ),
          ],
        ),
      ),
    );
  }
}

class FieldDisplay extends StatelessWidget {
  final String text;

  const FieldDisplay({required this.text, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(width: 15.0),
        IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
      ],
    );
  }
}
