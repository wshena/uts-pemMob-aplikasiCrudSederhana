// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PatientModelAdapter extends TypeAdapter<PatientModel> {
  @override
  final int typeId = 0;

  @override
  PatientModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PatientModel()
      ..patient_id = fields[0] as String
      ..patient_name = fields[1] as String
      ..patient_age = fields[2] as String
      ..patient_address = fields[3] as String
      ..patient_bloodType = fields[4] as String
      ..patient_diagnose = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, PatientModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.patient_id)
      ..writeByte(1)
      ..write(obj.patient_name)
      ..writeByte(2)
      ..write(obj.patient_age)
      ..writeByte(3)
      ..write(obj.patient_address)
      ..writeByte(4)
      ..write(obj.patient_bloodType)
      ..writeByte(5)
      ..write(obj.patient_diagnose);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PatientModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
