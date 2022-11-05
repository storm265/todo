// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archieve_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArchieveModelAdapter extends TypeAdapter<ArchieveModel> {
  @override
  final int typeId = 2;

  @override
  ArchieveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ArchieveModel(
      deadlineDateTime: fields[1] as DateTime?,
      text: fields[0] as String,
      category: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ArchieveModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.deadlineDateTime)
      ..writeByte(2)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArchieveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
