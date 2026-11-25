import 'package:tugas_sqf/data/database/db_helper.dart';
import 'package:tugas_sqf/model/barang.dart';

class BarangDao {
  final DbHelper _dbHelper;

  BarangDao(this._dbHelper);

  static const _nameTable = DbHelper.tabelName;

  Future<int> insert(Barang barang) async {
    final db = await _dbHelper.database;
    return db.insert(_nameTable, barang.toMap());
  }

  Future<List<Barang>> getAllBarang() async {
    final db = await _dbHelper.database;
    final getData = await db.query(_nameTable, orderBy: 'id DESC');
    return getData.map(Barang.fromMap).toList();
  }

  Future<int> update(Barang barang) async {
    final db = await _dbHelper.database;
    return db.update(
      _nameTable,
      barang.toMap(),
      where: 'id = ?',
      whereArgs: [barang.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await _dbHelper.database;
    return db.delete(
      _nameTable,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}