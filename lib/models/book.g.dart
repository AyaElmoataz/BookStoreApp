// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      title: fields[0] as String,
      subtitle: fields[1] as String,
      isbn13: fields[2] as String,
      price: fields[3] as String,
      image: fields[4] as String,
      url: fields[5] as String,
      authors: fields[6] as String?,
      publisher: fields[7] as String?,
      isbn10: fields[8] as String?,
      pages: fields[9] as String?,
      year: fields[10] as String?,
      rating: fields[11] as String?,
      description: fields[12] as String?,
      pdf: (fields[13] as Map?)?.cast<String, String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.subtitle)
      ..writeByte(2)
      ..write(obj.isbn13)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.url)
      ..writeByte(6)
      ..write(obj.authors)
      ..writeByte(7)
      ..write(obj.publisher)
      ..writeByte(8)
      ..write(obj.isbn10)
      ..writeByte(9)
      ..write(obj.pages)
      ..writeByte(10)
      ..write(obj.year)
      ..writeByte(11)
      ..write(obj.rating)
      ..writeByte(12)
      ..write(obj.description)
      ..writeByte(13)
      ..write(obj.pdf);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
