class Todo {
  final String documentId;
  final String title;

  Todo({this.documentId, this.title});

  Todo.fromJson(Map<String, dynamic> json)
      : documentId = json['documentId'],
        title = json['title'];
}
