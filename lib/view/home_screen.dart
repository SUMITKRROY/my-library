import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/route/route_generater.dart';
import 'package:mylibrary/utils/image.dart';
import '../component/my_container.dart';
import '../database/table/user_profile_db.dart';
import 'auth/login_screen.dart';
import 'member detail/member.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  User? _currentUser;

  bool _isLoading = false;
  late PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;
  String userName = ""; // Default name, will be updated from the database
  String userId = "";
  List<Map<String, dynamic>> profile = [];

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
    "Card_Name": [
      {
        "img": ImagePath.active,
        "heading": "Active user",
      },
      {
        "img": ImagePath.allUser,
        "heading": "All user",
      },
      {
        "img": ImagePath.inactive,
        "heading": "Inactive user",
      },
      {
        "img": ImagePath.account,
        "heading": "Account",
      },
      {
        "img": ImagePath.addMember,
        "heading": "Add user",
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
  static const Duration _timerDuration = Duration(seconds: 3); // Timer interval
  static const Duration _animationDuration = Duration(milliseconds: 300); // Animation speed


  void _startTimer() {
    _timer = Timer.periodic(_timerDuration, (Timer timer) {
      if (_currentPage < product['library']['banner']-1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: _animationDuration,
        curve: Curves.easeInOut,
      );
    });
  }
  // Function to fetch user name from the database
  Future<void> _fetchUserName() async {
    ProfileTable profileTable = ProfileTable();
      var data = await profileTable.getProfile();
    setState(() {
      profile = data;
      userName = profile.first['Name'] ?? "User Name"; // Update userName from the profile
      userId = profile.first['UserId'] ?? "userId"; // Update userName from the profile
      print("user id $userId");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
       // backgroundColor: Colors.deepPurple.withOpacity(0.8),
        elevation: 0.0,
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
                Navigator.pushNamed(
                  context,
                  RoutePath.reminderPage,
                );
              },
              icon: Icon(Icons.notifications_active)),
        ],
      ),
      drawer: Drawer(
        backgroundColor:   Colors.deepPurple,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color:   Colors.deepPurple.withOpacity(0.8),
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
                _signOut();

              },
            ),
          ],
        ),
      ),
      body: GradientContainer(
        child: Column(
          children: [
            Container(
              height: 150.h,
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
            SizedBox(height:10.h),
            MyText(
              label: "My Service",
              fontSize: 24,
              fontColor: Colors.white,
              alignment: true,
            ),
            SizedBox(height:10.h),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: grid_Details['Card_Name'].length,
                itemBuilder: (context, index) {
                  String gridTitle =
                      grid_Details['Card_Name'][index]['heading'];
                 String gridImage =     grid_Details['Card_Name'][index]['img'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (index == 3) {
                          Navigator.pushNamed(
                            context,
                            RoutePath.totalCollection,
                          );
                        } else if (index == 4) {

                          Navigator.pushNamed(context, RoutePath.bookSeats);
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
                          image: DecorationImage(
                            image: AssetImage(gridImage), // Provide the image path here
                            fit: BoxFit.cover, // Adjust how the image is displayed (cover, contain, etc.)
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: Colors.white12,
                            width: 1.0,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5), // Black background with 50% opacity
                              borderRadius: BorderRadius.circular(4.0), // Optional: Rounded corners
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Add padding for spacing
                            child:  MyText(
                              label: gridTitle,
                              fontSize: 14.sp,
                              fontColor: Colors.white, // White text color
                              alignment: true,
                            ),
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
  Future<void> _signOut() async {
    try {
      // Sign out from Google and Firebase
      await googleSignIn.signOut();
      await firebaseAuth.signOut();

      // Clear current user info
      setState(() {
        _currentUser = null;
      });
      List<Map<String, dynamic>> profiles = await ProfileTable().getProfile();
      print("cheaked ${profiles.first[ProfileTable.loginStatus]}");
      String   userId = profiles.first[ProfileTable.userId];
      // Update login status in the database
      await ProfileTable().updateLoginStatus(  userId: userId, status: false);

      // Navigate to login page after sign-out and status update
      Navigator.pushReplacementNamed(context, RoutePath.login);
    } catch (e) {
      print("Error during sign out: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error during sign out: $e")));
    }
  }

  Future<void> updateLoginStatus(BuildContext context) async {
    try {
      // Assuming 'userId' is available here and is the correct identifier

    } catch (e) {
      print("Error updating login status: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

}


