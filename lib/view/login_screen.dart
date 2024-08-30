import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/myTextForm.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _phone = TextEditingController();

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
                        controller: _name,
                        validator: false,
                        //validatorLabel: 'Email',
                        validatorFunc: Utils.emailValidator(),
                      ),
                        SizedBox(
                        height: 20.sp,
                      ),
                      MyTextForm(
                        keyboardType: TextInputType.text,textInputAction: TextInputAction.done,
                        label: 'Password',
                        onChanged: (value) {
                          print('Text changed: $value');
                        },
                        controller: _phone,
                        validator: false,
                        validatorFunc: Utils.passwordValidator(),
                        validatorLabel: 'Password',
                      ),
                        SizedBox(
                        height: 20.sp,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Validate returns true if the form is valid, or false otherwise.
                          if (_formKey.currentState!.validate()) {
                            // If the form is valid, display a snackbar. In the real world,
                            // you'd often call a server or save the information in a database.
                            Navigator.pushNamed(context, RoutePath.homeScreen);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
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
}
