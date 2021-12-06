import 'package:flutter/material.dart';
import './models/todo.dart';
import './widgets/todos_list.dart';
import './widgets/new_todo.dart';

void main() => runApp(const MyApp());

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

final List<TODO> todos = [];

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
    setState(() {
      todos.add(newTODO);
    });
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
    setState(() {
      todos[index].done ? todos[index].done = false : todos[index].done = true;
    });
  }

  void _deleteTODO(int index) {
    setState(() {
      todos.removeAt(index);
    });
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
              child: TodosList(
                todos: todos,
                changeStatus: _changeStatus,
                deleteTODO: _deleteTODO,
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
