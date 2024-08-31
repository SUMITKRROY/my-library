import 'package:flutter/material.dart';
import 'package:mylibrary/component/container.dart';
import 'package:mylibrary/component/myText.dart';

class MemberScreen extends StatefulWidget {
  final String title;
  final String message;
    MemberScreen({super.key, required this.title, required this.message});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(label: widget.title, fontSize: 18, fontColor: Colors.white),
      ),
      body: GradientContainer(child: Container()),
    );
  }
}
