import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorSelectionPage extends StatefulWidget {
  @override
  _ColorSelectionPageState createState() => _ColorSelectionPageState();
}

class _ColorSelectionPageState extends State<ColorSelectionPage> {
  Color _circleColor = Colors.grey;

  void _selectGreenColor() {
    setState(() {
      _circleColor = Colors.green;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Color'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: _circleColor,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _selectGreenColor,
              child: Text('Select Green'),
            ),
          ],
        ),
      ),
    );
  }
}