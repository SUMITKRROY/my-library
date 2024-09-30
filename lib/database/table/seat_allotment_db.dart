import 'package:sqflite/sqflite.dart';
import '../database_helper.dart';

class SeatAllotment {
  static const String SEAT_ALLOTMENT = "SEAT_ALLOTMENT";
  static const String shift = "SHIFT";
  static const String name = "Name";
  static const String amount = "Amount";
  static const String memberId = "MEMBER_ID";
  static const String chairNo = "CHAIR_NO";
  static const String dateOfJoining = "Date_Of_Joining";
  static const String memberStatus = "MemberStatus";

  static const String totalCollection = "TotalCollection";

  static const String CREATE = '''
    CREATE TABLE IF NOT EXISTS $SEAT_ALLOTMENT (
    $memberId TEXT PRIMARY KEY,
    $name TEXT DEFAULT '',
    $shift TEXT DEFAULT '',
    $chairNo TEXT DEFAULT '',
    $amount TEXT DEFAULT '',
    $dateOfJoining TEXT DEFAULT '',
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

  Future<List<Map<String, dynamic>>> getInactiveMembers() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    return await db.query(
      SEAT_ALLOTMENT,
      where: '$memberStatus = ?',
      whereArgs: ['inactive'], // Fetch only members with 'inactive' status
    );
  }


  Future<void> updateMemberStatus({required String memberId}) async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;

    try {
      // Update the member status to 'inactive'
      await db.update(
        SEAT_ALLOTMENT,
        {'$memberStatus': 'inactive'}, // Set the column name correctly to 'MemberStatus'
        where: 'MEMBER_ID = ?', // Update where MEMBER_ID matches
        whereArgs: [memberId], // Bind the memberId argument
      );
      print("Successfully updated member ID: $memberId to status: inactive");
    } catch (e) {
      print("Error updating member status: $e");
    }
  }

// Define a function that calculates the total collection from the 'Amount' field
  Future<double> getTotalCollection() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;

    // Query the sum of the 'Amount' field from the database
    var result = await db.rawQuery('SELECT SUM(CAST($amount AS $totalCollection)) as total FROM $SEAT_ALLOTMENT');

    // Extract the total value from the query result
    if (result.isNotEmpty && result[0]['total'] != null) {
      return result[0]['total'] as double;
    } else {
      return 0.0; // Return 0 if no values are present
    }
  }


  Future<List<Map<String, dynamic>>> getFilteredSeatData() async {
    try {
      // Fetch the data from the SeatAllotment table
      List<Map<String, dynamic>> seatData = await SeatAllotment().getUserData();

      // Use map to filter only shift and chairNo
      List<Map<String, dynamic>> filteredData = seatData.map((data) {
        return {
          'shift': data['SHIFT'],
          'chairNo': data['CHAIR_NO'],
        };
      }).toList();

      return filteredData;
    } catch (e) {
      print("Error fetching and filtering seat data: $e");
      return [];
    }
  }



}
