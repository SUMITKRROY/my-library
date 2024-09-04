import 'package:sqflite/sqflite.dart';

import '../database_helper.dart';

class ProfileTable {
  static const String PROFILE_TABLE = "PROFILE_TABLE";
  static const String name = "Name";
  static const String phone = "Phone";
  static const String email = "Email";
  static const String password = "Password";
  static const String userId = "UserId";
  static const String totalSeats = "TOTAL_SEATS";
  static const String profileImage = "ProfileImage";

  static const String CREATE = '''
    CREATE TABLE IF NOT EXISTS $PROFILE_TABLE (
      $userId TEXT PRIMARY KEY,
      $name TEXT DEFAULT '',
      $phone TEXT DEFAULT '',

      $totalSeats INTEGER DEFAULT 0,
      $profileImage TEXT DEFAULT ''
    )
  ''';

  // Insert profile data into the database
  Future<void> insert(Map<String, dynamic> profile) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    await db.insert(
      PROFILE_TABLE,
      profile,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // // Retrieve profile data from the database
  // Future<Map<String, dynamic>?> getProfile() async {
  //   DatabaseHelper databaseHelper = DatabaseHelper();
  //   final db = await databaseHelper.database;
  //   List<Map<String, dynamic>> result = await db.query(
  //     PROFILE_TABLE,
  //     limit: 1,
  //   );
  //   return result.isNotEmpty ? result.first : null;
  // }
  // Method to retrieve all cycles from the database
  Future<List<Map<String, dynamic>>> getProfile() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    return await db.query(PROFILE_TABLE);
  }

  // Delete profile data from the database
  Future<int> deleteProfile() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    return await db.delete(
      PROFILE_TABLE,
    );
  }
}
