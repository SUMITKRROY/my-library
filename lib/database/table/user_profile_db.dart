import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../../route/pageroute.dart';
import '../database_helper.dart';

class ProfileTable {
  static const String PROFILE_TABLE = "PROFILE_TABLE";
  static const String name = "Name";
  static const String phone = "Phone";
  static const String email = "Email";
  static const String password = "Password";
  static const String userId = "UserId";
  static const String totalSeats = "TOTAL_SEATS";
  static const String loginStatus = "LoginStatus";

  static const String CREATE = '''
    CREATE TABLE IF NOT EXISTS $PROFILE_TABLE (
      $userId TEXT PRIMARY KEY,
      $name TEXT DEFAULT '',
      $phone TEXT DEFAULT '',
      $totalSeats INTEGER DEFAULT 0,
      $email TEXT DEFAULT '',
      $password TEXT DEFAULT '',
      $loginStatus TEXT DEFAULT ''
    )
  ''';

// Insert profile data into the database
  Future<void> insert(Map<String, dynamic> profile, BuildContext context) async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      final db = await databaseHelper.database;
      await db.insert(
        PROFILE_TABLE,
        profile,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print("Data inserted successfully");

      // Navigate to the next screen after successful insertion
      Navigator.pushReplacementNamed(context, RoutePath.homeScreen);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
    } catch (e) {
      print("Error inserting data: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inserting data: $e')),
      );
    }
  }

  // Update the login status in the database
  Future<void> updateLoginStatus(String userId, bool status) async {
    try {
      DatabaseHelper databaseHelper = DatabaseHelper();
      final db = await databaseHelper.database;
      await db.update(
        PROFILE_TABLE,
        {
          loginStatus: status ? 'true' : 'false',
        },
        where: '$userId = ?',
        whereArgs: [userId],
      );
      print("Login status updated successfully");
    } catch (e) {
      print("Error updating login status: $e");
    }
  }

  // Retrieve the profile of the logged-in user
  Future<Map<String, dynamic>?> getLoggedInProfile() async {
    DatabaseHelper databaseHelper = DatabaseHelper();
    final db = await databaseHelper.database;
    List<Map<String, dynamic>> result = await db.query(
      PROFILE_TABLE,
      where: '$loginStatus = ?',
      whereArgs: ['true'],
      limit: 1,
    );
    return result.isNotEmpty ? result.first : null;
  }

  // Method to retrieve all profiles from the database
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
