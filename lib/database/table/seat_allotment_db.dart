import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';

class SeatAllotment {
  static const String SEAT_ALLOTMENT = "SEAT_ALLOTMENT";
  static const String shift = "SHIFT";
  static const String memberId = "MEMBER_ID";
  static const String chairNo = "CHAIR_NO";
  static const String memberStatus = "MemberStatus";

  static const String CREATE = '''
    CREATE TABLE IF NOT EXISTS $SEAT_ALLOTMENT (
    $memberId TEXT PRIMARY KEY,
    $shift TEXT DEFAULT '',
    $chairNo TEXT DEFAULT '',
    $memberStatus TEXT DEFAULT ''
    )
  ''';

  // Define a function that inserts notes into the database
  Future<void> insert(Map<String, dynamic> map) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    // Get a reference to the database.
    final db = await databaseHelper.database;
    // In this case, replace any previous data.
    await db.insert(
      SEAT_ALLOTMENT,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Method to retrieve all notes from the database
  Future<List<Map<String, dynamic>>> getUserData() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    return await db.query(SEAT_ALLOTMENT);
  }

  // Method to delete a note from the database
  Future<int> deleteUserData() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    return await db.delete(
      SEAT_ALLOTMENT,
    );
  }

  // Method to get active members
  Future<List<Map<String, dynamic>>> getActiveMembers() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    return await db.query(
      SEAT_ALLOTMENT,
      where: '$memberStatus = ?',
      whereArgs: ['Active'],
    );
  }




  Future<void> updateMemberStatus(String memberId) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;

    await db.update(
      SEAT_ALLOTMENT,
      {memberStatus: 'inactive'},
      where: '$memberId = ?',
      whereArgs: [memberId],
    );
  }
}
