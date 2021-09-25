// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_category.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrxCategoryAdapter extends TypeAdapter<TrxCategory> {
  @override
  final int typeId = 2;

  @override
  TrxCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrxCategory(
      name: fields[1] as String,
      colorCode: fields[2] as int,
    )..id = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, TrxCategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.colorCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrxCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
