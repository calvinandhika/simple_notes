class NotesModel {
  final String title;
  final String description;
  final String category;
  DateTime date;

  NotesModel({
    required this.title,
    required this.description,
    required this.category,
    date,
  }) : date = DateTime.now();

  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      title: json['title'],
      description: json['description'],
      category: json['category'],
      date: json['date'],
    );
  }
}
