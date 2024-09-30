import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class LoginPageFortestinng extends StatefulWidget {
  @override
  _LoginPageFortestinngState createState() => _LoginPageFortestinngState();
}

class _LoginPageFortestinngState extends State<LoginPageFortestinng> {
  Map<String, dynamic>? _userDetail;
  String _message = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _login();
  }

  Future<void> _login() async {
    var headers = {
      'Authorization': 'Bearer 558|276VcDwAA0F6RpIl3qou29QpeMqgCvO99zzmmHuo'
    };
    var data = FormData.fromMap({
      'username': 'Anshu',
      'password': '12345678'
    });

    var dio = Dio();

    try {
      var response = await dio.request(
        'https://lms.unitemicrosystems.in/api/login.php',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.data);
        if (responseData['success']) {
          setState(() {
            _userDetail = responseData['userdetail'];
            _message = responseData['msg'];
            _isLoading = false;
          });
        } else {
          setState(() {
            _message = 'Login failed';
            _isLoading = false;
          });
        }
      } else {
        setState(() {
          _message = 'Error: ${response.statusMessage}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Exception: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: _isLoading
            ? CircularProgressIndicator()
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_message.isNotEmpty) ...[
                Text(
                  _message,
                  style: TextStyle(fontSize: 16, color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
              ],
              if (_userDetail != null) ...[
                Text(
                  'User ID: ${_userDetail!['id']}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Full Name: ${_userDetail!['userfullname']}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Username: ${_userDetail!['username']}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'User Type: ${_userDetail!['usertype']}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
