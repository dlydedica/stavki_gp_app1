import 'package:mysql1/mysql1.dart';

class DBHandler {
  final ConnectionSettings settings;

  DBHandler(this.settings);

  Future<MySqlConnection> _getConnection() async {
    return await MySqlConnection.connect(settings);
  }

  Future<void> create(String table, Map<String, dynamic> data) async {
    final conn = await _getConnection();
    try {
      var keys = data.keys.join(',');
      var values = data.values.map((v) => "'$v'").join(',');
      await conn.query('INSERT INTO $table ($keys) VALUES ($values)');
    } finally {
      await conn.close();
    }
  }

  Future<Results> read(String table, {String? where}) async {
    final conn = await _getConnection();
    try {
      var query = 'SELECT * FROM $table';
      if (where != null) {
        query += ' WHERE $where';
      }
      return await conn.query(query);
    } finally {
      await conn.close();
    }
  }

  Future<void> update(
      String table, Map<String, dynamic> data, String where) async {
    final conn = await _getConnection();
    try {
      var updates = data.entries.map((e) => "${e.key}='${e.value}'").join(',');
      await conn.query('UPDATE $table SET $updates WHERE $where');
    } finally {
      await conn.close();
    }
  }

  Future<void> delete(String table, String where) async {
    final conn = await _getConnection();
    try {
      await conn.query('DELETE FROM $table WHERE $where');
    } finally {
      await conn.close();
    }
  }
}
