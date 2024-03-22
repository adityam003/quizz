import 'package:flutter/material.dart';
import 'contest2.dart';
import 'contest3.dart';
import 'contest1.dart'; // Import the next page where you want to navigate
import 'dart:math';

class LiveContest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' '),
        backgroundColor: Color(0xFFCC78FF),
        automaticallyImplyLeading: true, // Remove the arrow icon
      ),
      backgroundColor: Color(0xFFCC78FF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Text(
                  'Live Contest',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 150),
                GestureDetector(
                  onTap: () {
                    _showRulesDialog(context);
                  },
                  child: Text(
                    'Rules',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Contest1()), // Replace Contest1() with your next page widget
              );
            },
            child: buildContainer('Science', Random().nextInt(11)),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Contest2()), // Replace Contest2() with your next page widget
              );
            },
            child: buildContainer('Information Technology', Random().nextInt(11)),
          ),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Contest3()), // Replace Contest3() with your next page widget
              );
            },
            child: buildContainer('Computer Science', Random().nextInt(11)),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Upcoming',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          EmptyLoadingBar(), // Add empty loading bar here
        ],
      ),
    );
  }

  Widget buildContainer(String subject, int playerCount) {
    double progress = playerCount / 10; // Calculate the progress value

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Color(0xFFE8F6F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    subject,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Spacer(),
                  Text(
                    '20Q',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(width: 5),
              Row(
                children: [
                  Text(
                    '$playerCount/10 Players', // Show the actual player count
                  ),
                ],
              ),
              SizedBox(height: 5),
              Container(
                width: double.infinity,
                height: 10,
                child: LinearProgressIndicator(
                  value: progress, // Set the progress value
                  backgroundColor: Color(0xFF56B9F0),
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF211EE1)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRulesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Rules"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("• Fair Play: Play with integrity; no cheating or manipulation allowed."),
                Text("• Eligibility: Only registered users can participate, following age and location regulations."),
                Text("• Contest Duration: Contest times are specified; late entries not accepted."),
                Text('• Disqualification: Immediate disqualification for disrupting the contest or violating rules.'),
                Text('• User Conduct: Respectful behavior expected; no inappropriate content allowed.'),
                // Add more rules as needed
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class EmptyLoadingBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: Color(0xFFE8F6F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No upcoming contests',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LiveContest(),
  ));
}