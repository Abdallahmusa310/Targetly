// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'target_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TargetModelAdapter extends TypeAdapter<TargetModel> {
  @override
  final int typeId = 1;

  @override
  TargetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TargetModel(
      target: fields[0] as double,
      commission: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, TargetModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.target)
      ..writeByte(1)
      ..write(obj.commission);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TargetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
