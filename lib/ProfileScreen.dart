import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color(0xFF2BCAFF), // Set appbar background color to 2BCAFF
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Option 1'),
              onTap: () {
                // Add navigation logic here
              },
            ),
            ListTile(
              title: Text('Option 2'),
              onTap: () {
                // Add navigation logic here
              },
            ),
          ],
        ),
      ),
      body: ProfileContent(),
    );
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(50),
      alignment: Alignment.center,
      color: Color(0xFF2BCAFF), // Set background color to 2BCAFF
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18), // Add border radius
                    border: Border.all(
                      color: Colors.white,
                      // width: 2,
                    ),
                  ),
                  child: ClipRRect( // Clip rounded corners
                    borderRadius: BorderRadius.circular(18),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1511367461989-f85a21fda167?q=80&w=1931&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "User Name", // Replace "Name" with actual name
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _buildInfoField("Name", "Your Name Here"), // Replace "Your Name Here" with actual name
          SizedBox(height: 20),
          _buildInfoField("Email", "your@example.com"), // Replace "your@example.com" with actual email
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure buttons are spaced evenly
            children: [
              Flexible(
                flex: 1,
                child: _buildButton("Change Password", () {
                  // Implement functionality for changing password
                }),
              ),
              _buildButton("Logout", () {
                // Implement logout functionality
              }, color: Colors.red), // Setting button color to red
            ],
          ),
          Spacer(),
          Text(
            "Made with ❤️ from India",
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 60),
        ],
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFE8F6F6),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Color(0xFF8E7A7A)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, {Color? color}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Color(0xFF007BFF),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ProfileScreen(),
  ));
}