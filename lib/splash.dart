import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/route/route_generater.dart';
import 'package:mylibrary/view/login_screen.dart';
import 'package:mylibrary/utils/image.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 03), () {
     Navigator.pushReplacementNamed(context, RoutePath.login);
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
    });
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
            //    color: Colors.white,
              ),
              SizedBox(
                height: 10.h,
              ),
              Column(
                children: [
              //    MyText(label: "Library ", fontSize: 30.sp, fontColor: Colors.white),
                  // MyText(lable: lable, fontsize: fontsize, fontcolor: fontcolor)
                  Text(
                    'Library',
                    style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  // MyText(label: "Focus on", fontSize: 20.sp, fontColor: Colors.white,alignment: true,),
                  // MyText(
                  //   label: "your goal",
                  //   fontSize: 16.sp,
                  //   fontColor: Colors.white,
                  //   alignment: true,
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
