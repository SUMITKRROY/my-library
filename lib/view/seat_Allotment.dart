import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/container.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/component/myTextForm.dart';
import 'package:mylibrary/component/mybutton.dart';

import '../utils/image.dart';

class BookSeats extends StatefulWidget {
  final String totalSeats;

  const BookSeats({
    super.key,
    required this.totalSeats,
  });

  @override
  State<BookSeats> createState() => _BookSeatsState();
}

class _BookSeatsState extends State<BookSeats> {
  late List<bool> _selectedItems;
  final TextEditingController _memberIdController = TextEditingController();
  String _errorText = '';

  @override
  void initState() {
    super.initState();
    _selectedItems = List<bool>.generate(11, (index) => false); // 11 items
  }

  @override
  void dispose() {
    _memberIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          label: "My Library (${widget.totalSeats} seats)",
          fontSize: 14.sp,
          fontColor: Colors.white,
        ),
      ),
      body: GradientContainer(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSeatInfoColumn("All Seats", widget.totalSeats),
                  _buildSeatInfoColumn("Allotted", "0"),
                  _buildSeatInfoColumn("Un Allotted", widget.totalSeats),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyText(label: "Morning"),
                      MyText(label: "Afternoon"),
                      MyText(label: "Evening"),
                      MyText(label: "Night"),
                      MyText(label: "FullDay"),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _memberIdController,
                        decoration: InputDecoration(
                          labelText: "Enter member id",
                          labelStyle: TextStyle(color: Colors.white),
                          filled: true,
                          fillColor: Colors.transparent,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          errorText: _errorText.isNotEmpty ? _errorText : null,
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _errorText = _memberIdController.text.isEmpty
                              ? "Member ID cannot be empty"
                              : '';
                        });
                        if (_errorText.isEmpty) {
                          // Implement your button logic here
                        }
                      },
                      child: MyText(label: "Get Seat"),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(8.0),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: _selectedItems.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedItems[index] = !_selectedItems[index];
                        });
                      },
                      child: Semantics(
                        label: 'Seat ${index + 1}',
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: Image.asset(
                                ImagePath.chair,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              bottom: 4,
                              left: 2,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                child: MyText(
                                  label: 'S-${index + 1}',
                                  fontColor: Colors.white,
                                ),
                              ),
                            ),
                            if (_selectedItems[index])
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 24,
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSeatInfoColumn(String label, String value) {
    return Column(
      children: [
        MyText(label: label),
        Container(
          width: 50.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.white),
          ),
          child: MyText(
            label: value,
            alignment: true,
          ),
        ),
      ],
    );
  }
}
