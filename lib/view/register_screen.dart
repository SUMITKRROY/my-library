import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/component/myTextForm.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/utils/utils.dart';

import '../database/table/user_profile_db.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _name = TextEditingController();
  TextEditingController _userId = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _totalSeats = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  Map<String, dynamic> appDetailSet = {};



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
                      'Welcome,',
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'to our library!',
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
                            label: 'User Id',
                            controller: _userId,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(06),
                            ],
                            keyboardType: TextInputType.text,
                            validator: true,
                            validatorFunc: Utils.userIdValidator(),
                            onChanged: (String ) {  },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          MyTextForm(
                            label: 'Name',
                            controller: _name,
                            keyboardType: TextInputType.text,
                            validator: true,
                        validatorLabel: "name",
                            onChanged: (String ) {  },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          MyTextForm(
                            label: 'Phone Number',
                            controller: _phone,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(10),
                            ],
                            keyboardType: TextInputType.phone,
                            validator: true,
                            validatorFunc: Utils.phoneValidator(),
                            onChanged: (String ) {  },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          MyTextForm(
                            label: 'Email',
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            validator: true,
                            validatorFunc: Utils.emailValidator(),
                            onChanged: (String ) {  },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          MyTextForm(
                            label: 'Total Seats',
                            controller: _totalSeats,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(3),
                            ],
                            keyboardType: TextInputType.number,
                            validator: true,
                            validatorLabel: "total seats",
                            onChanged: (String ) {  },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          MyTextForm(
                            label: 'Password',
                            controller: _password,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            validator: true,
                            validatorFunc: Utils.passwordValidator(), onChanged: (String ) {  },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          MyTextForm(
                            label: 'Confirm Password',
                            controller: _confirmPassword,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            onChanged: (String ) {  },
                            validator: true,
                            validatorFunc: (value) {
                              if (value != _password.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                   appTableSet(context);
                                // Navigator.pushNamed(context, RoutePath.homeScreen);
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(content: Text('Processing Data')),
                                // );
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
                                  'Register',
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
                                  onTap: (){
                                    Navigator.pushReplacementNamed(context, RoutePath.login);
                                  },
                                  child: MyText(label: "Already have an account?",fontColor:  Color(0xff63A6DC), fontSize: 22.sp,),
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

  void appTableSet(BuildContext context) async {
    try {
      appDetailSet[ProfileTable.userId] = _userId.text;
      appDetailSet[ProfileTable.name] = _name.text;
      appDetailSet[ProfileTable.phone] = _phone.text;
      appDetailSet[ProfileTable.email] = _email.text;
      appDetailSet[ProfileTable.totalSeats] = int.tryParse(_totalSeats.text) ?? 0; // Parse to integer
      appDetailSet[ProfileTable.password] = _password.text; // Changed to .text
      appDetailSet[ProfileTable.loginStatus] = "true"; // Changed to .text

      // Call insert method with profile data and context for navigation
      await ProfileTable().insert(appDetailSet, context);
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }


}
