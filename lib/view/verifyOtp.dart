import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;
  int _start = 30;
  bool _canResend = false;
  late List<FocusNode> _otpFocusNodes;
  final List<TextEditingController> _otpControllers =
  List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    startTimer();
    _otpFocusNodes = List.generate(6, (index) => FocusNode());
  }

  void startTimer() {
    setState(() {
      _canResend = false;
      _start = 30;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          _canResend = true;
        });
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _otpFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff63A6DC),
                  Color(0xff281537),
                ],
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 80.0, left: 22),
              child: Text(
                'Verify OTP',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 200.h),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
                color: Colors.white,
              ),
              height: double.infinity,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.h, vertical: 40.h),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            6,
                                (index) => Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: _otpControllers[index],
                                  focusNode: _otpFocusNodes[index],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  maxLength: 1,
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    if (value.isNotEmpty) {
                                      if (index < _otpFocusNodes.length - 1) {
                                        FocusScope.of(context).requestFocus(
                                            _otpFocusNodes[index + 1]);
                                      } else {
                                        FocusScope.of(context).unfocus();
                                      }
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter OTP';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: _canResend ? startTimer : null,
                                child: Text(
                                  _canResend
                                      ? 'Resend OTP'
                                      : 'Resend OTP in $_start seconds',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: _canResend
                                        ? const Color(0xff281537)
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing OTP')),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Please enter OTP'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Container(
                            height: 55,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xff63A6DC),
                                  Color(0xff281537),
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                'VERIFY OTP',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                "Change Mobile no.?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "change",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.blue,
                                  ),
                                ),
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
      ),
    );
  }
}
