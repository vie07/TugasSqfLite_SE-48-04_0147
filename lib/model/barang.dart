// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Barang {
  final int? id;
  final String nama;
  final int stok;

  Barang({
    this.id,
    required this.nama,
    required this.stok,
  });

  Barang copyWith({
    int? id,
    String? nama,
    int? stok,
  }) {
    return Barang(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      stok: stok ?? this.stok,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'stok': stok,
    };
  }

  factory Barang.fromMap(Map<String, dynamic> map) {
    return Barang(
      id: map['id'] != null ? map['id'] as int : null,
      nama: map['nama'] as String,
      stok: map['stok'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Barang.fromJson(String source) =>
      Barang.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Barang(id: $id, nama: $nama, stok: $stok)';

  @override
  bool operator ==(covariant Barang other) {
    if (identical(this, other)) return true;

    return other.id == id && other.nama == nama && other.stok == stok;
  }

  @override
  int get hashCode => id.hashCode ^ nama.hashCode ^ stok.hashCode;
}