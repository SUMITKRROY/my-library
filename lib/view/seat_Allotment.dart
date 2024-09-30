import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/container.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/component/myTextForm.dart';
import 'package:mylibrary/component/mybutton.dart';
import 'package:mylibrary/database/table/seat_allotment_db.dart';
import 'package:mylibrary/database/table/user_profile_db.dart';
import 'package:mylibrary/provider/seat_allotment/getseat_bloc.dart';
import 'package:mylibrary/route/pageroute.dart';
import 'package:mylibrary/utils/utils.dart';
import 'package:mylibrary/utils/image.dart';

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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _dateOfJoiningController = TextEditingController();
  int _selectedPeriodIndex = -1; // To keep track of the selected period index
  int _totalMembers = 0;
  int _totalSeats = 0;

  @override
  void initState() {
    super.initState();
    _selectedChairIndex = -1; // No chair selected initially
    _dateOfJoiningController.text = Utils.getFormattedDate(DateTime.now()); // Set today's date
    _fetchTotalMembers();
  }

  @override
  void dispose() {
    _memberIdController.dispose();
    _nameController.dispose();
    _amountController.dispose();
    _dateOfJoiningController.dispose();
    super.dispose();
  }

  Future<void> _fetchTotalMembers() async {
    try {
      List<Map<String, dynamic>> data = await SeatAllotment().getUserData();
      List<Map<String, dynamic>> profileData = await ProfileTable().getProfile();
      setState(() {
        _totalMembers = data.length;
        _totalSeats = profileData.first['TOTAL_SEATS'];
      });
    } catch (e) {
      print("Error fetching total members: $e");
    }
  }

  Future<void> _refreshData() async {
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
                    // Seat info columns
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildSeatInfoColumn("All Seats", "${_totalSeats}"),
                        _buildSeatInfoColumn("Allotted", "${_totalMembers}"),
                        _buildSeatInfoColumn("Un Allotted", "${_totalSeats - _totalMembers}"),
                      ],
                    ),
                    // Shift selection buttons
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
                    // Form fields
                    _buildTextFormField(_memberIdController, "Enter member id"),
                    _buildTextFormField(_nameController, "Enter name"),
                    _buildTextFormField(_amountController, "Enter amount"),
                    _buildTextFormField(_dateOfJoiningController, "Date of Joining", enabled: false),

                    // Get Seat button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_selectedChairIndex == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please select a chair before proceeding.'),
                                  ),
                                );
                              } else if (_selectedPeriodIndex == -1) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please select a shift before proceeding.'),
                                  ),
                                );
                              } else if (_formKey.currentState!.validate()) {
                                context.read<GetSeatBloc>().add(
                                  InsertSeatEvent(
                                    selectedShift: _getShiftLabel(_selectedPeriodIndex),
                                    memberId: _memberIdController.text.trim(),
                                    chairNo: "S-${_selectedChairIndex + 1}",
                                    memberStatus: 'Active',
                                    name: _nameController.text.trim(),
                                    amount: _amountController.text.trim(),
                                    dateOfJoining: _dateOfJoiningController.text.trim(),
                                  ),
                                );
                              }
                            },
                            child: MyText(label: "Get Seat"),
                          ),
                        ),
                      ],
                    ),
                    // Chair Grid
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

  // Builds the shift selection buttons
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

  // Builds the form fields for user input
  Widget _buildTextFormField(TextEditingController controller, String label, {bool enabled = true}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Please enter a valid value';
          }
          return null;
        },
      ),
    );
  }

  // Builds the seat info display columns
  Widget _buildSeatInfoColumn(String title, String count) {
    return Column(
      children: [
        MyText(label: title, fontColor: Colors.white),
        MyText(label: count, fontColor: Colors.white),
      ],
    );
  }

  // Gets the shift label based on the selected index
  String _getShiftLabel(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return "Morning";
      case 1:
        return "Afternoon";
      case 2:
        return "Evening";
      case 3:
        return "Night";
      case 4:
        return "FullDay";
      default:
        return "";
    }
  }
}
