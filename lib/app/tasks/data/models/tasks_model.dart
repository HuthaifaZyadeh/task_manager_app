import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/todo_tasks.dart';
import 'task_model.dart';

part 'tasks_model.g.dart';

@JsonSerializable()
class TasksModel extends TodoTasks {
  const TasksModel({
    required super.todos,
    required super.total,
    required super.skip,
    required super.limit,
  });

  factory TasksModel.fromJson(Map<String, dynamic> json) =>
      _$TasksModelFromJson(json);

  Map<String, dynamic> toJson() => _$TasksModelToJson(this);
}
