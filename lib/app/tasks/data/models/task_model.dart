import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/todo_task.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel extends TodoTask {
  const TaskModel({
    required super.id,
    required super.todo,
    required super.completed,
    required super.userId,
    required super.isDeleted,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
