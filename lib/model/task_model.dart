class TaskModel {
  int? id;
  String? title;
  String? description;
  bool? isCompleted;
  String? createdAt;
  int? userId;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.isCompleted,
    this.createdAt,
    this.userId,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    isCompleted = json['isCompleted'];
    createdAt = json['createdAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt,
      'userId': userId,
    };
  }
}