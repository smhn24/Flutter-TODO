import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/todo.dart';

class TodosList extends StatelessWidget {
  final List<TODO> todos;
  final Function changeStatus;
  final Function deleteTODO;

  const TodosList({
    required this.todos,
    required this.changeStatus,
    required this.deleteTODO,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Sorry, Nothing added yet...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                const SizedBox(height: 45.0),
                SizedBox(
                  height: 175.0,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 5.0,
            ),
            child: ListView.builder(
              itemBuilder: (_, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 4.0,
                  child: ListTile(
                    title: Text(todos[index].name.toString()),
                    leading: CircleAvatar(
                      child: Text('${index + 1}'),
                    ),
                    subtitle: Text(
                      DateFormat('yyyy/MM/dd').format(todos[index].time),
                    ),
                    trailing: SizedBox(
                      width: 100.0,
                      child: Row(
                        children: [
                          todos[index].done
                              ? IconButton(
                                  onPressed: () => changeStatus(index),
                                  icon: const Icon(Icons.check_box),
                                  color: Colors.green,
                                )
                              : IconButton(
                                  onPressed: () => changeStatus(index),
                                  icon:
                                      const Icon(Icons.check_box_outline_blank),
                                  color: Colors.green,
                                ),
                          IconButton(
                            onPressed: () => deleteTODO(context, index),
                            icon: const Icon(Icons.delete),
                            color: ThemeData().errorColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: todos.length,
            ),
          );
  }
}
