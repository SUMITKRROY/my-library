import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
            Row(
              children: [
                Text(
                  "₹ 10",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(width: 20),
                Icon(Icons.notifications, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Banner Section
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/library_banner.jpg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Tab Bar Section
          Container(
            color: Colors.purple,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'All',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Recent',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          // Grid Section
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(10),
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              children: [
                _buildGridItem(
                  context,
                  'Active',
                  'assets/active_users.jpg', // Replace with your image path
                ),
                _buildGridItem(
                  context,
                  'All Users',
                  'assets/all_users.jpg', // Replace with your image path
                ),
                _buildGridItem(
                  context,
                  'Inactive Users',
                  'assets/inactive_users.jpg', // Replace with your image path
                ),
                _buildGridItem(
                  context,
                  'Account',
                  'assets/account.jpg', // Replace with your image path
                ),
                _buildGridItem(
                  context,
                  'Recent',
                  'assets/recent.jpg', // Replace with your image path
                ),
                _buildGridItem(
                  context,
                  'Add Member',
                  'assets/add_member.jpg', // Replace with your image path
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridItem(BuildContext context, String title, String imagePath) {
    return GestureDetector(
      onTap: () {
        // Add navigation or functionality here
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              color: Colors.black.withOpacity(0.5),
              padding: EdgeInsets.all(10),
              child: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
