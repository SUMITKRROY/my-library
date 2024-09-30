import 'package:flutter/material.dart';
import 'package:mylibrary/component/container.dart';
import '../component/myText.dart';
import '../database/table/seat_allotment_db.dart';
import 'seat_allotment.dart'; // Make sure to import your SeatAllotment class

class TotalCollection extends StatefulWidget {
  const TotalCollection({super.key});

  @override
  State<TotalCollection> createState() => _TotalCollectionState();
}

class _TotalCollectionState extends State<TotalCollection> {
  final SeatAllotment _seatAllotment = SeatAllotment();

  double totalCollection = 0.0;
  int activeMembersCount = 0;
  int inactiveMembersCount = 0;
  List<Map<String, dynamic>> collections = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    // Update the UI
    setState(() async {
      totalCollection = await _seatAllotment.getTotalCollection();
      collections = await _seatAllotment.getUserData();
      activeMembersCount = (await _seatAllotment.getActiveMembers()).length;
      inactiveMembersCount = (await _seatAllotment.getInactiveMembers()).length;
      print("totalCollection ${totalCollection}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(label: "Total Collection", fontSize: 18, fontColor: Colors.white),
      ),
      body: GradientContainer(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(label: "Total Amount Collected: ₹${totalCollection.toStringAsFixed(2)}", fontSize: 20, fontColor: Colors.black),
              const SizedBox(height: 20),
              MyText(label: "Active Members: $activeMembersCount", fontSize: 16, fontColor: Colors.black),
              MyText(label: "Inactive Members: $inactiveMembersCount", fontSize: 16, fontColor: Colors.black),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: collections.length,
                  itemBuilder: (context, index) {
                    final item = collections[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: MyText(label: item['MEMBER_ID'], fontSize: 16, fontColor: Colors.black),
                        subtitle: MyText(label: "Amount: ₹${item['Amount']}", fontSize: 14, fontColor: Colors.grey),
                        trailing: MyText(label: item['MemberStatus'].toUpperCase(), fontSize: 14, fontColor: item['MemberStatus'] == 'Active' ? Colors.green : Colors.red),
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
}
