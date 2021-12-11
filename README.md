# TODO application

**TODO** apllication for **CS50** final project.

#### Video Demo:  https://youtu.be/91qB2TgGXTc

#### Description:
This is my Final project for ***CS50*** course. This is a **TODO** list application for **Mobile**(Android and iOS), **Desktop**(Windows, Linux and MacOS) and **Web** with **Flutter** framework.

You may ask me **What is a TODo list?** The answer is simple: To Do list is a list of tasks you want to complete, or tasks you want to do.

About **Flutter** (From documentation):
- Flutter is an open source framework by Google for building beautiful, natively compiled, multi-platform applications from a single codebase.
- Flutter code compiles to ARM or Intel machine code as well as JavaScript, for fast performance on any device.
- Flutter is powered by Dart, a language optimized for fast apps on any platform
- ...

In this application to save TODOs in mobile storage I used Hive database and as you know Hive is a Fast, Enjoyable & Secure NoSQL Database.

About **Hive** (From documentation):
- Hive is a lightweight and blazing fast key-value database written in pure Dart. Inspired by Bitcask.
- All data stored in Hive is organized in **boxes**. A box can be compared to a table in SQL, but it does not have a structure and can contain anything.
- ...

To save TODOs with Hive, I make my TODO model like this:
```dart
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
```
