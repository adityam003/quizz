import 'package:flutter/material.dart';

class Contest3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Computer Science'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get ready for the Live Quiz!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Answer the questions as fast as you can to win!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/011/055/338/non_2x/quiz-time-button-quiz-time-speech-bubble-quiz-time-text-web-template-illustration-vector.jpg',
              width: 200, // Adjust the width as needed
            ),
            SizedBox(height: 20), // Add some space
            TextButton(
              onPressed: () {
                // Add functionality to start the live quiz
                // For example, you can navigate to another screen
              },
              child: Text(
                'Start Live Quiz',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                ),
                shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Contest3(),
  ));
}