import 'package:moralpain/models/option.dart';

class Question {
  final String sectionId;
  final String title;
  final String subtitle;
  final List<Option> options;

  Question(
    this.sectionId,
    this.title,
    this.subtitle,
    this.options,
  );

  Question.fromJson(Map<String, dynamic> json)
      : sectionId = json['sectionId'],
        title = json['title'],
        subtitle = json['subtitle'],
        options =
            List<Option>.from(json['options'].map((o) => Option.fromJson(o)));
}
