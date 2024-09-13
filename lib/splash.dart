import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/route/route_generater.dart';
import 'package:mylibrary/utils/image.dart';
import '../database/table/user_profile_db.dart'; // Import your ProfileTable class

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    // Simulate a delay
    await Future.delayed(Duration(seconds: 3));

    try {
      ProfileTable profileTable = ProfileTable();
      List<Map<String, dynamic>> profiles = await profileTable.getProfile();

      // Assuming there's only one user profile, or you want to check the first one
      if (profiles.isNotEmpty) {
        bool loginStatus = profiles[0][ProfileTable.loginStatus] == 'true';
        print("cheaked ${loginStatus}");
        if (loginStatus) {
          Navigator.pushReplacementNamed(context, RoutePath.homeScreen);
        } else {
          Navigator.pushReplacementNamed(context, RoutePath.login);
        }
      } else {
        Navigator.pushReplacementNamed(context, RoutePath.login);
      }
    } catch (e) {
      print("Error checking login status: $e");
      Navigator.pushReplacementNamed(context, RoutePath.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff63A6DC),
              Color(0xff281537),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                ImagePath.logo,
                height: 250.h,
                width: 250.h,
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                children: [
                  Text(
                    'Library',
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
