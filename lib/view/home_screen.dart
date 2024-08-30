import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/route/route_generater.dart';

import '../component/container.dart';
import '../component/mybutton.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  Map<String, dynamic> product = {
    "library": {
      "banner": [
        {"img_url": "assets/banner/1st.jpg"},
        {"img_url": "assets/banner/2nd.jpg"},
        {"img_url": "assets/banner/3rd.jpg"},
        {"img_url": "assets/banner/4th.jpg"},
      ],
    }
  };

  Map<String, dynamic> grid_Details = {
    "PREMIUM_BOUTIQUES": [
      {"icon": "", "heading": "Live Member", "count": "0"},
      {"icon": "", "heading": "total member", "count": "1"},
      {"icon": "", "heading": "Expired Member", "count": "3"},
      {"icon": "", "heading": "Expired Member | 3-4 days", "count": "5"},
      {"icon": "", "heading": "Expired Member | 4-7 days", "count": "5"},
      {"icon": "", "heading": "Expired Member | 8-15 days", "count": "5"},
      {"icon": "", "heading": "Total Collection", "count": "5"},
      {"icon": "", "heading": "Total Exp", "count": "2"},
      {"icon": "", "heading": "Due amount", "count": "4"}
    ]
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (Timer timer) {
      if (_currentPage < product['library']['banner'].length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Color(0xff63A6DC),
        title:
            MyText(label: "My library", fontSize: 24, fontColor: Colors.white),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person_3_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.chair_alt)),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Color(0xff63A6DC),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff63A6DC),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/profile_image.png'), // Replace with your image asset path
                  ),
                  SizedBox(height: 10),
                  Text(
                    'User Name',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to home screen
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to settings screen
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pushReplacementNamed(context, RoutePath.login);
                // Handle logout action
              },
            ),
            // Add more ListTile widgets here for other buttons
          ],
        ),
      ),
      body: GradientContainer(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 250.h,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: product['library']['banner'].length,
                  itemBuilder: (BuildContext context, int index) {
                    return Image.asset(
                      product['library']['banner'][index]['img_url'],
                      fit: BoxFit.cover,
                    );
                  },
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                ),
              ),
              MyText(
                label: "My Service",
                fontSize: 24,
                fontColor: Colors.white,
                alignment: true,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: grid_Details['PREMIUM_BOUTIQUES'].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RoutePath.memberScreen,
                            arguments: index,  // Replace 1 with the dynamic index value you want to pass
                          );

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            border: Border.all(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              grid_Details['PREMIUM_BOUTIQUES'][index]
                                  ['heading'],
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
