import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/container.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/component/mybutton.dart';

class BookSeats extends StatefulWidget {
  String totalSeats;
  BookSeats({super.key, required this.totalSeats});

  @override
  State<BookSeats> createState() => _BookSeatsState();
}

class _BookSeatsState extends State<BookSeats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
            label: "My Library(${widget.totalSeats} seats)",
            fontSize: 14,
            fontColor: Colors.white),
      ),
      body: GradientContainer(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                    children: [
            // Container(
            //   height: 100.h,
            //   child: GridView.builder(
            //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 3,  // Number of columns
            //       childAspectRatio: 1, // Adjust this to control the height of each grid cell
            //     ),
            //     itemCount: 3, // Number of items in the grid
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.only(left: 8.0),
            //         child: Column(
            //           children: [
            //             Text('Text $index'), // Text in the first column
            //             Container(
            //               margin: EdgeInsets.all(10.0),
            //               padding: EdgeInsets.all(10.0),
            //               color: Colors.blueAccent,
            //               child: Text(
            //                 'Inside Container $index', textAlign: TextAlign.center,
            //                 style: TextStyle(color: Colors.white),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     },
            //   )
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    MyText(
                      label: "All Seats",
                    ),
                    Container(
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            // Adds a border to all sides of the container
                            color: Colors.white, // Border color
                          ),
                        ),
                        child: MyText(
                          label: widget.totalSeats,
                          alignment: true,
                        ))
                  ],
                ),
                Column(
                  children: [
                    MyText(
                      label: "Allotted",
                    ),
                    Container(
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            // Adds a border to all sides of the container
                            color: Colors.white, // Border color
                          ),
                        ),
                        child: MyText(
                          label: "0",
                          alignment: true,
                        ))
                  ],
                ),
                Column(
                  children: [
                    MyText(
                      label: "Un Allotted",
                    ),
                    Container(
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          border: Border.all(
                            // Adds a border to all sides of the container
                            color: Colors.white, // Border color
                          ),
                        ),
                        child: MyText(
                          label: widget.totalSeats,
                          alignment: true,
                        ))
                  ],
                ),
              ],
            ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white

                            )
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
                      )
                    ],
                  ),
          )),
    );
  }
}
