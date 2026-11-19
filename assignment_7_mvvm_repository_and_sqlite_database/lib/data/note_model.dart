class Note {
  final int? id;
  final String title;
  final String description;

  Note({
    this.id,
    required this.title,
    required this.description,
  });

  // Convert a Note object into a Map for SQLite.
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'title': title,
      'description': description,
    };
  }

  // Convert a Map from SQLite into a Note object.
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}