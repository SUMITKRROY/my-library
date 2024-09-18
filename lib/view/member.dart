import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylibrary/component/container.dart';
import 'package:mylibrary/component/myText.dart';
import 'package:mylibrary/utils/theme_changer.dart';
import '../database/table/seat_allotment_db.dart';
import '../provider/member_details/member_details_bloc.dart';
import '../provider/member_details/member_details_event.dart';
import '../provider/member_details/member_details_state.dart';

class MemberScreen extends StatefulWidget {
  final String title;
  final int index;

  MemberScreen({super.key, required this.title, required this.index});

  @override
  State<MemberScreen> createState() => _MemberScreenState();
}

class _MemberScreenState extends State<MemberScreen> {
  late MemberBloc _memberBloc;

  @override
  void initState() {
    super.initState();
    _memberBloc = MemberBloc(SeatAllotment());

    // Pass the index to the Bloc to fetch members
    _memberBloc.add(FetchMembersEvent(widget.index));
  }

  @override
  void dispose() {
    _memberBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(label: widget.title, fontSize: 18, fontColor: Colors.white),
      ),
      body: BlocBuilder<MemberBloc, MemberState>(
        bloc: _memberBloc,
        builder: (context, state) {
          if (state is MemberLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MemberSuccess) {
            return GradientContainer(
              child: state.members.isEmpty
                  ? Center(child: MyText(label: 'No Active Members'))
                  :ListView.builder(
                itemCount: state.members.length,
                itemBuilder: (context, index) {
                  print("state : ${state}");
                  // Determine the color based on member status
                  Color cardColor = state.members[index]['MemberStatus'] == 'inactive'
                      ? Colors.red
                      : ColorsData.backToTopBackgroundColor;

                  Color iconbutton = state.members[index]['MemberStatus'] == 'inactive'
                      ? Colors.white
                      : Colors.red;

                  return GestureDetector(
                    onTap: () {
                      print("Tapped on member ${state.members[index]['MEMBER_ID']}");
                    },
                    child: Card(
                      color: cardColor,
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListTile(
                          leading: MyText(label: 'ID: ${state.members[index]['MEMBER_ID']}'),
                          title: MyText(label: 'Shift: ${state.members[index]['SHIFT']}', fontSize: 16.sp),
                          subtitle: MyText(label: 'Chair No: ${state.members[index]['CHAIR_NO']}', fontSize: 12.sp),
                          trailing: IconButton(
                            onPressed: () {
                              _memberBloc.add(UpdateMemberStatusEvent(state.members[index]['MEMBER_ID']));
                            },
                            icon: Icon(Icons.delete),
                            color:
                            iconbutton
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )

            );
          } else if (state is MemberFailure) {
            return Center(child: Text('Error: ${state.error}'));
          }
          return const Center(child: Text('No data available'));
        },
      ),
    );
  }
}

