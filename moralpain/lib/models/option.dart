class Option {
  final String id;
  final String description;

  Option(
    this.id,
    this.description,
  );

  Option.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'];
}
