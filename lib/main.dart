import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './models/boxes.dart';
import './models/todo.dart';
import './widgets/todos_list.dart';
import './widgets/new_todo.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TODOAdapter());
  await Hive.openBox<TODO>('todos');

  runApp(const MyApp());
}

final appBar = AppBar(
  title: const Text(
    'TODO list application',
  ),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(
      bottom: Radius.circular(35.0),
    ),
  ),
  centerTitle: true,
);

List<TODO> todos = [];

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO app',
      home: const MyHome(),
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: 'OpenSans',
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: 'OpenSans',
      ),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  void _addNewTODO(String id, String name, DateTime time) {
    final newTODO = TODO(id: id, name: name, time: time);
    final box = Boxes.getTODOs();
    box.add(newTODO);
  }

  void _startAddingNewTODO(BuildContext ctx) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      elevation: 5.0,
      context: ctx,
      builder: (_) {
        return SingleChildScrollView(
          child: GestureDetector(
            onTap: () {},
            child: AddNewTODO(_addNewTODO),
            behavior: HitTestBehavior.opaque,
          ),
        );
      },
    );
  }

  void _changeStatus(int index) {
    todos[index].done ? todos[index].done = false : todos[index].done = true;
    todos[index].save();
  }

  void _deleteTODO(BuildContext ctx, int index) {
    showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 5.0,
        content: const Text(
          'Are you sure to delete this TODO?',
          style: TextStyle(fontSize: 17.5),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              todos[index].delete();
              Navigator.of(context).pop();
            },
            child: const Text('Delete'),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11.0),
              ),
              primary: ThemeData().errorColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  1,
              child: ValueListenableBuilder<Box<TODO>>(
                valueListenable: Boxes.getTODOs().listenable(),
                builder: (context, box, _) {
                  todos = box.values.toList().cast<TODO>();
                  return TodosList(
                    todos: todos,
                    changeStatus: _changeStatus,
                    deleteTODO: _deleteTODO,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _startAddingNewTODO(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
