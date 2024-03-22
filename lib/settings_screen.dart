import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF2BCAFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Edit Profile',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Edit Username'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String newUsername = ''; // Variable to store new username
                    return AlertDialog(
                      title: Text("Change Username"),
                      content: TextField(
                        onChanged: (value) {
                          newUsername = value; // Update new username as user types
                        },
                        decoration: InputDecoration(hintText: "New Username"),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close dialog on cancel
                          },
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Process username change here, e.g., send to server
                            // For now, just print the new username
                            print('New Username: $newUsername');
                            Navigator.of(context).pop(newUsername); // Pass the new username as result
                          },
                          child: Text('Change'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Edit Profile Photo'),
              onTap: () {
                // Implement edit profile photo functionality
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About Us'),
              onTap: () {
                // Show alert with the provided content
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("About Us"),
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Unleash Your Inner Genius with Quizlet",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "At Quizlet, we believe in the power of intelligent learning. We're not just a flashcard app – we're your AI-powered study companion, here to transform the way you learn.",
                            ),
                            // Add the rest of the content here...
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Invite Friends'),
              onTap: () {
                // Implement invite friends functionality
              },
            ),
            SizedBox(height: 20),
            Center( // Center the text
              child: Text(
                'From\nTeam DevDyn', // Add line break to separate "From" and "Team DevDyn"
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center, // Center the text horizontally
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Implement logout functionality
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Background color set to red
          ),
          child: Text('Log Out', style: TextStyle(color: Colors.white)), // Set text color to white
        ),
      ),
    );
  }
}