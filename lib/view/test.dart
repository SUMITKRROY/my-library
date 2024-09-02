import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/utils/image.dart';



class SelectableGridView extends StatefulWidget {
  @override
  _SelectableGridViewState createState() => _SelectableGridViewState();
}

class _SelectableGridViewState extends State<SelectableGridView> {
  late List<bool> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List<bool>.generate(11, (index) => false); // 11 items
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4, // Adjust based on the number of columns needed
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
          child: Stack(
            children: [
              // Image in full-screen within the grid cell
              Positioned.fill(
                child: Image.asset(
                  ImagePath.chair, // Path to your image
                  fit: BoxFit.cover, // Makes the image cover the entire container
                ),
              ),
              // Serial number at the top-left corner with specific styling
              Positioned(
                bottom: 4,
                left: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 06, vertical: 2),
                  decoration: BoxDecoration(
                      color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: MyText(
                    label: 'S-${index + 1}',
                    fontColor: Colors.white, // White text color
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
        );
      },
    );
  }
}
