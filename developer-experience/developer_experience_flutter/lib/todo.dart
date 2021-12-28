class Todo {
  final String id;
  final String title;
  final String description;
  final String updatedAt;
  
  Todo({required this.id, required this.title, required this.description,       
  required this.updatedAt});
  
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      updatedAt: json['updatedAt']
    );
  }

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
  };
}