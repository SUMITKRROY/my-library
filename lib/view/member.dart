import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mylibrary/component/container.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/utils/theme_changer.dart';
import '../database/table/seat_allotment_db.dart';

class MemberScreen extends StatefulWidget {
  final String title;
  final int index;

  MemberScreen({super.key, required this.title, required this.index});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  List<Map<String, dynamic>> _members = []; // List to store active members data

  @override
  void initState() {
    super.initState();
    _fetchMembers(); // Call function to fetch members based on index
  }

  Future<void> _fetchMembers() async {
    try {
      SeatAllotment SEAT_ALLOTMENT = SeatAllotment();
      //List<Map<String, dynamic>> allMembers = await SEAT_ALLOTMENT.getUserData();

      if(widget.index==0){
        List<Map<String, dynamic>> allMembers = await SEAT_ALLOTMENT.getActiveMembers();
        setState(() {
          _members = allMembers; // Update the members list
        });
      }else if(widget.index==1){
        List<Map<String, dynamic>> allMembers = await SEAT_ALLOTMENT.getUserData();
        setState(() {
          _members = allMembers; // Update the members list
        });
      }else{
        List<Map<String, dynamic>> allMembers = await SEAT_ALLOTMENT.getUserData();
        setState(() {
          _members = allMembers; // Update the members list
        });
      }



      print("All member data: ${_members.length}");
    } catch (e) {
      print("Error fetching members: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(label: widget.title, fontSize: 18, fontColor: Colors.white),
      ),
      body: GradientContainer(
        child: _members.isEmpty
            ? Center(child: MyText(label: 'No Active Members'))
            : ListView.builder(
          itemCount: _members.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Add any action you want to trigger on card tap
                print("Tapped on member ${_members[index]['MEMBER_ID']}");
              },
              child: Card(
                color: ColorsData.backToTopBackgroundColor,
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 15),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListTile(
                    leading: MyText(label: 'ID: ${_members[index]['MEMBER_ID']}'),
                    title: MyText(label: 'Shift: ${_members[index]['SHIFT']}', fontSize: 16.sp),
                    subtitle: MyText(
                      label: 'Chair No: ${_members[index]['CHAIR_NO']}',
                      fontSize: 12.sp,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        _deactivateMember(_members[index]['MEMBER_ID']);
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  Future<void> _deactivateMember(String memberId) async {
    print("Attempting to update member ID: $memberId to status: inactive");
    try {
      SeatAllotment SEAT_ALLOTMENT = SeatAllotment();
      await SEAT_ALLOTMENT.updateMemberStatus(memberId);
      print("Successfully updated member ID: $memberId");
      // Refresh the member list after updating
      await _fetchMembers();
    } catch (e) {
      print("Error updating member status: $e");
    }
  }
}
