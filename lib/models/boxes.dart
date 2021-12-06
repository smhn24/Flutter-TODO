import 'package:hive/hive.dart';
import './todo.dart';

class Boxes {
  static Box<TODO> getTODOs() => Hive.box<TODO>('todos');
}
