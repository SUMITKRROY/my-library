import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';

class SeatAllotment {
  static const String SEAT_ALLOTMENT = "SEAT_ALLOTMENT";
  static const String shift = "SHIFT";
  static const String totalSeats = "TOTAL_SEATS";
  static const String memberId = "MEMBER_ID";
  static const String chairNo = "CHAIR_NO";

  static const String CREATE = '''
    CREATE TABLE IF NOT EXISTS $SEAT_ALLOTMENT (
    $memberId TEXT PRIMARY KEY,
    $totalSeats INTEGER DEFAULT 0,
    $shift TEXT DEFAULT '',
    $chairNo TEXT DEFAULT ''
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

  //filter out data 15 day or 30 day

  // Method to delete a note from the database
  Future<int> deleteUserData() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    return await db.delete(
      SEAT_ALLOTMENT,
      //  where: '$id = ?',
      // whereArgs: [noteId],
    );
  }
}
