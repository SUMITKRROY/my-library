import 'package:flutter/material.dart';
import 'package:mylibrary/component/container.dart';

class MemberScreen extends StatefulWidget {

  const MemberScreen({super.key});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        backgroundColor: Color(0xff63A6DC),
      ),
      body: GradientContainer(child: Container()),
    );
  }
}
