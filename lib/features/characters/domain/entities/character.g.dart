// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterAdapter extends TypeAdapter<Character> {
  @override
  final typeId = 0;

  @override
  Character read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Character(
      id: (fields[0] as num).toInt(),
      name: fields[1] as String,
      status: fields[2] as String,
      species: fields[3] as String,
      location: fields[4] as String,
      imageUrl: fields[5] as String,
      isFavorite: fields[6] == null ? false : fields[6] as bool,
      gender: fields[7] == null ? 'Unknown' : fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Character obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.species)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.imageUrl)
      ..writeByte(6)
      ..write(obj.isFavorite)
      ..writeByte(7)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CharacterImpl _$$CharacterImplFromJson(Map<String, dynamic> json) =>
    _$CharacterImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      isFavorite: json['isFavorite'] as bool? ?? false,
      gender: json['gender'] as String? ?? 'Unknown',
    );

Map<String, dynamic> _$$CharacterImplToJson(_$CharacterImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'location': instance.location,
      'imageUrl': instance.imageUrl,
      'isFavorite': instance.isFavorite,
      'gender': instance.gender,
    };
