class DraftModel {
  String id;
  String title;
  String description;
  DateTime lastEdited;

  DraftModel({
    required this.id,
    required this.title,
    required this.description,
    required this.lastEdited,
  });

  factory DraftModel.fromJson(Map<String, dynamic> json) => DraftModel(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    lastEdited: DateTime.parse(json['lastEdited']),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'lastEdited': lastEdited.toIso8601String(),
  };
}
