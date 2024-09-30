import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/route/route_generater.dart';
import '../component/container.dart';
import '../component/mybutton.dart';
import '../database/table/seat_allotment_db.dart';
import '../database/table/user_profile_db.dart';
import 'login_screen.dart';
import 'member.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  String userName =
      "User Name"; // Default name, will be updated from the database

  final Map<String, dynamic> product = {
    "library": {
      "banner": [
        {"img_url": "assets/banner/1st.jpg"},
        {"img_url": "assets/banner/2nd.jpg"},
        {"img_url": "assets/banner/3rd.jpg"},
        {"img_url": "assets/banner/4th.jpg"},
      ],
    }
  };

  final Map<String, dynamic> grid_Details = {
    "PREMIUM_BOUTIQUES": [
      {
        "heading": "Live Member",
      },
      {
        "heading": "Total Member",
      },
      {
        "heading": "Expired Member",
      },
      {
        "heading": "Collection report",
      },
    ]
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startTimer();
    _fetchUserName(); // Fetch the user name when the screen initializes
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

  // Function to fetch user name from the database
  Future<void> _fetchUserName() async {
    ProfileTable profileTable = ProfileTable();
    var profile = await profileTable.getLoggedInProfile();
    setState(() {
      userName =
          profile?['Name'] ?? "User Name"; // Update userName from the profile
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            MyText(label: "My Library", fontSize: 24, fontColor: Colors.white),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutePath.profile);
              },
              icon: Icon(Icons.person_3_rounded)),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutePath.bookSeats);
              },
              icon: Icon(Icons.chair_alt)),
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
                    backgroundImage: AssetImage("assets/images/Profile.gif"),
                  ),
                  SizedBox(height: 10),
                  Text(
                    userName,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Colors.white),
              title: Text('Home', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Navigate to home screen if not already there
              },
            ),
            ListTile(
              leading: Icon(Icons.picture_as_pdf, color: Colors.white),
              title: Text('pdf screen', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pushNamed(context, RoutePath.pdfPage);
                // Navigate to home screen if not already there
              },
            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                // Navigator.pushNamed(context, RoutePath.settings);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              onTap: () {
                // Handle logout action
                Navigator.pushReplacementNamed(context, RoutePath.login);
              },
            ),
          ],
        ),
      ),
      body: GradientContainer(
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
                  String gridTitle =
                      grid_Details['PREMIUM_BOUTIQUES'][index]['heading'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (index == 3) {
                          Navigator.pushNamed(
                            context,
                            RoutePath.totalCollection,
                          );
                        } else {
                          Navigator.pushNamed(
                            context,
                            RoutePath.memberScreen,
                            arguments: MemberScreen(
                              title: gridTitle,
                              index: index,
                            ),
                          );
                        }
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
                              offset: Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: Center(
                          child: MyText(
                            label: gridTitle,
                            fontSize: 14.sp,
                            fontColor: Colors.white,
                            alignment: true,
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
    );
  }
}
