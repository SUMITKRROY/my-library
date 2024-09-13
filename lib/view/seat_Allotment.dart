import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/container.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/component/myTextForm.dart';
import 'package:mylibrary/component/mybutton.dart';
import 'package:mylibrary/database/table/seat_allotment_db.dart';
import 'package:mylibrary/provider/seat_allotment/getseat_bloc.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/utils/utils.dart';
import '../database/table/user_profile_db.dart';
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
  late int _selectedChairIndex;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _memberIdController = TextEditingController();
  int _selectedPeriodIndex = -1; // To keep track of the selected period index
  Map<String, dynamic> appDetailSet = {};
  int _totalMembers = 0; // To hold the total number of members
  int _totalSeats = 0; // To hold the total number of Seats

  @override
  void initState() {
    super.initState();
    _selectedChairIndex = -1; // No chair selected initially
    _fetchTotalMembers();
  }

  @override
  void dispose() {
    _memberIdController.dispose();
    super.dispose();
  }

  Future<void> _fetchTotalMembers() async {
    try {
      List<Map<String, dynamic>> data = await SeatAllotment().getUserData();
      List<Map<String, dynamic>> profileData = await ProfileTable().getProfile();
      print("profileData: $profileData");
      setState(() {
        _totalMembers = data.length; // Assuming each entry represents a member
        _totalSeats = profileData.first['TOTAL_SEATS'];
        print("_totalMembers: $_totalSeats");
      });
    } catch (e) {
      print("Error fetching total members: $e");
    }
  }

  Future<void> _refreshData() async {
    // Call the method to fetch data and update the UI
    await _fetchTotalMembers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetSeatBloc, GetSeatState>(
      listener: (context, state) {
        if (state is GetSeatSuccess) {
          Navigator.pushReplacementNamed(context, RoutePath.homeScreen);
        } else if (state is GetSeatError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error allotting seat. Please try again.'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: MyText(
            label: "My Library (${_totalSeats} seats)",
            fontSize: 14.sp,
            fontColor: Colors.white,
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Form(
            key: _formKey,
            child: GradientContainer(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSeatInfoColumn("All Seats", "${_totalSeats}"),
                        _buildSeatInfoColumn("Allotted", "${_totalMembers}"),
                        _buildSeatInfoColumn("Un Allotted", "${_totalSeats - _totalMembers}"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildPeriodButton(0, "Morning"),
                            _buildPeriodButton(1, "Afternoon"),
                            _buildPeriodButton(2, "Evening"),
                            _buildPeriodButton(3, "Night"),
                            _buildPeriodButton(4, "FullDay"),
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
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.red),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return "Member id is required";
                                }
                                return null;
                              },
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                context.read<GetSeatBloc>().add(
                                  InsertSeatEvent(
                                    selectedShift: _getShiftLabel(_selectedPeriodIndex),
                                    memberId: _memberIdController.text.trim(),
                                    chairNo: "S-${_selectedChairIndex + 1}",
                                    memberStatus: 'Active',
                                  ),
                                );
                              }
                            },
                            child: MyText(label: "Get Seat"),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.all(8.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemCount: widget.totalSeats.isNotEmpty ? int.parse(widget.totalSeats) : 0,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedChairIndex = _selectedChairIndex == index ? -1 : index;
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
                                  if (_selectedChairIndex == index)
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
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodButton(int index, String label) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPeriodIndex = _selectedPeriodIndex == index ? -1 : index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: _selectedPeriodIndex == index ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
        ),
        child: MyText(
          label: label,
          fontColor: Colors.white,
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

  String _getShiftLabel(int index) {
    switch (index) {
      case 0:
        return 'Morning';
      case 1:
        return 'Afternoon';
      case 2:
        return 'Evening';
      case 3:
        return 'Night';
      case 4:
        return 'FullDay';
      default:
        return '';
    }
  }
}
