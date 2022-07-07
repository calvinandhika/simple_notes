const String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [id, title, description, category, date];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String category = 'category';
  static const String date = 'date';
}

class NoteModel {
  final int? id;
  final String title;
  final String description;
  final String category;
  DateTime date;

  NoteModel({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    date,
  }) : date = DateTime.now();

  NoteModel copy({
    int? id,
    String? title,
    String? description,
    String? category,
    DateTime? date,
  }) =>
      NoteModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        date: date ?? this.date,
      );

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      id: json[NoteFields.id] as int?,
      title: json[NoteFields.title] as String,
      description: json[NoteFields.description] as String,
      category: json[NoteFields.category] as String,
      date: DateTime.parse(json[NoteFields.date] as String),
    );
  }

  Map<String, Object?> toJson() => {
        NoteFields.id: id,
        NoteFields.title: title,
        NoteFields.description: description,
        NoteFields.category: category,
        NoteFields.date: date.toIso8601String(),
      };
}
