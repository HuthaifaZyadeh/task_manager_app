abstract class ApiEndpoints {
  // Auth
  static const String auth = 'auth';
  static const String login = '$auth/login';
  static const String refresh = '$auth/refresh';
  static const String me = '$auth/me';

  // Todos
  static const String todos = 'todos';
  static const String updaeteTodo = 'todos/{id}';
  static const String deleteTodo = 'todos/{id}';
  static const String addTodo = '$todos/add';
}
