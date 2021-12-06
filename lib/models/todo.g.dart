// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TODOAdapter extends TypeAdapter<TODO> {
  @override
  final int typeId = 0;

  @override
  TODO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TODO(
      id: fields[0] as String,
      name: fields[1] as String,
      time: fields[2] as DateTime,
    )..done = fields[3] as bool;
  }

  @override
  void write(BinaryWriter writer, TODO obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TODOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
