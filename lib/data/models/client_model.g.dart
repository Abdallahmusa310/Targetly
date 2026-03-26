// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClinetModelAdapter extends TypeAdapter<ClinetModel> {
  @override
  final int typeId = 0;

  @override
  ClinetModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ClinetModel(
      clinetname: fields[0] as String,
      clinetphone: fields[1] as String,
      clinetid: fields[2] as String,
      clinetfees: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ClinetModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.clinetname)
      ..writeByte(1)
      ..write(obj.clinetphone)
      ..writeByte(2)
      ..write(obj.clinetid)
      ..writeByte(3)
      ..write(obj.clinetfees);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClinetModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
