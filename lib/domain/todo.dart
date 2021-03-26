class Todo {
  final String title;

  Todo({this.title});

  Todo.fromJson(Map<String, dynamic> json) : title = json['title'];
}
