import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/component/myTextForm.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/utils/utils.dart';
import '../database/table/user_profile.dart'; // Import your ProfileTable class

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
                  Color(0xff63A6DC),
                  Color(0xff281537),
                ]),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 60.h, left: 22, bottom: 40.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello,',
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Sign in!',
                      style: TextStyle(
                          fontSize: 35.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 200.h),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40), topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 30.h),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyTextForm(
                            label: 'Email',
                            onChanged: (value) {
                              print('Text changed: $value');
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                            validator: false,
                            validatorFunc: Utils.emailValidator(),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          MyTextForm(
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            label: 'Password',
                            onChanged: (value) {
                              print('Text changed: $value');
                            },
                            controller: _password,
                            validator: false,
                            validatorFunc: Utils.passwordValidator(),
                            validatorLabel: 'Password',
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          GestureDetector(
                            onTap: () async {
                              // Validate returns true if the form is valid, or false otherwise.
                              if (_formKey.currentState!.validate()) {
                                bool isAuthorized = await login(
                                  _email.text,
                                  _password.text,
                                );

                                if (isAuthorized) {
                                  Navigator.pushNamed(
                                      context, RoutePath.homeScreen);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Login Successful')),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                        Text('You are not authorized')),
                                  );
                                }
                              }
                            },
                            child: Container(
                              height: 55,
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(colors: [
                                  Color(0xff63A6DC),
                                  Color(0xff281537),
                                ]),
                              ),
                              child: const Center(
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, RoutePath.register);
                                  },
                                  child: MyText(
                                    label: "Create",
                                    fontColor: Color(0xff63A6DC),
                                    fontSize: 22.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 04.w,
                                ),
                                MyText(
                                  label: "New Account ?",
                                  fontColor: Colors.black,
                                  fontSize: 18.sp,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  // Function to handle login by checking the database
  Future<bool> login(String email, String password) async {
    try {
      ProfileTable profileTable = ProfileTable();
      List<Map<String, dynamic>> profiles = await profileTable.getProfile();
      for (var profile in profiles) {
        if (profile[ProfileTable.email] == email &&
            profile[ProfileTable.password] == password) {
          return true; // Email and password match
        }
      }
      return false; // No match found
    } catch (e) {
      print("Login error: $e");
      return false; // Handle errors
    }
  }
}
