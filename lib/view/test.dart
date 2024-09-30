import 'package:flutter/material.dart';

class ShiftScreen extends StatefulWidget {
  @override
  _ShiftScreenState createState() => _ShiftScreenState();
}

class _ShiftScreenState extends State<ShiftScreen> {
  // List of shifts
  List<String> shifts = ["Morning", "Afternoon", "Evening", "Night", "FullDay"];

  // Sample data to filter (users with shifts)
  List<Map<String, String>> userData = [
    {'name': 'User1', 'shift': 'Morning'},
    {'name': 'User2', 'shift': 'Afternoon'},
    {'name': 'User3', 'shift': 'Evening'},
    {'name': 'User4', 'shift': 'Night'},
    {'name': 'User5', 'shift': 'FullDay'},
    {'name': 'User6', 'shift': 'Morning'},
  ];

  // To store the currently selected shift index
  int selectedShiftIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shift Filter'),
      ),
      body: Column(
        children: [
          // Row of buttons to select shifts
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPeriodButton(0, "Morning"),
              _buildPeriodButton(1, "Afternoon"),
              _buildPeriodButton(2, "Evening"),
              _buildPeriodButton(3, "Night"),
              _buildPeriodButton(4, "FullDay"),
            ],
          ),

          SizedBox(height: 20),

          // List of users filtered by the selected shift
          Expanded(
            child: ListView(
              children: _filteredUsers().map((user) {
                return ListTile(
                  title: Text(user['name']!),
                  subtitle: Text(user['shift']!),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  // Function to build the shift buttons
  Widget _buildPeriodButton(int index, String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          selectedShiftIndex = index; // Update the selected shift index
        });
      },
      child: Text(label),
    );
  }

  // Function to filter the userData based on the selected shift
  List<Map<String, String>> _filteredUsers() {
    String selectedShift = shifts[selectedShiftIndex]; // Get the selected shift

    // Filter the users based on the selected shift
    return userData.where((user) => user['shift'] == selectedShift).toList();
  }
}

void main() {
  runApp(MaterialApp(
    home: ShiftScreen(),
  ));
}
