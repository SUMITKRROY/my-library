import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';  // Import ScreenUtil
import '../component/container.dart';
import '../database/table/user_profile_db.dart';
import '../route/pageroute.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? profileData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _getProfileData();
  }

  // Function to get profile data from the database
  Future<void> _getProfileData() async {
    ProfileTable profileTable = ProfileTable();
    var data = await profileTable.getLoggedInProfile();

    setState(() {
      profileData = data;
      isLoading = false;
    });
  }

  // Function to handle logout
  Future<void> _handleLogout() async {
    ProfileTable profileTable = ProfileTable();
    if (profileData != null && profileData![ProfileTable.userId] != null) {
      await profileTable.updateLoginStatus(profileData![ProfileTable.userId], false);
      Navigator.pushReplacementNamed(context, RoutePath.login); // Assuming you have a login screen route
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil for responsive sizing
    ScreenUtil.init(
      context,
      designSize: const Size(360, 690),  // Adjust based on your app's design dimensions
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontSize: 18.sp),  // Using ScreenUtil for font size
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _handleLogout,
          ),
        ],
      ),
      body: GradientContainer(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : profileData != null
            ? Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileRow("Name", profileData![ProfileTable.name] ?? ""),
              _buildProfileRow("Phone", profileData![ProfileTable.phone] ?? ""),
              _buildProfileRow("Email", profileData![ProfileTable.email] ?? ""),
              _buildProfileRow("Total Seats", profileData![ProfileTable.totalSeats].toString()),
              const SizedBox(height: 30),
              // Centering the logout button
              Center(
                child: ElevatedButton(
                  onPressed: _handleLogout,
                  child: Text(
                    "Logout",
                    style: TextStyle(fontSize: 16.sp),  // Font size using ScreenUtil
                  ),
                ),
              ),
            ],
          ),
        )
            : Center(child: Text('No profile data found', style: TextStyle(fontSize: 16.sp))),
      ),
    );
  }

  // Helper method to build profile data rows
  Widget _buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),  // Font size with ScreenUtil
          ),
          Text(
            value,
            style: TextStyle(fontSize: 14.sp),  // Font size with ScreenUtil
          ),
        ],
      ),
    );
  }
}
