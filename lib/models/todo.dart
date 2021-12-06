import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class TODO extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final DateTime time;

  @HiveField(3)
  bool done = false;

  TODO({required this.id, required this.name, required this.time});
}
