
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'dart:async';
import 'dart:math';


class Scoreboard extends StatefulWidget {

  final List<int> myList;

  Scoreboard(this.myList);

  @override
  _ScoreboardState createState() => _ScoreboardState(myList);
}

class _ScoreboardState extends State<Scoreboard> {
  final List<int> myList;
  _ScoreboardState(this.myList);
  int correctAnswers = 0;
  int incorrectAnswers = 0;
  double percentage = 0.0;
  int totalAnswers = 0;

  @override
  Widget build(BuildContext context) {
    for (int num in myList) {
      totalAnswers++;
      if (num == 1) {
        correctAnswers++;
      }
    }
     incorrectAnswers = totalAnswers - correctAnswers;
     percentage = (correctAnswers/totalAnswers) * 100;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Scoreboard'),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Center(
                      child: AnimatedContainer(
                        duration: Duration(seconds: 60),
                        curve: Curves.easeInOut,
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: percentage / 100,
                          strokeWidth: 15,
                          backgroundColor: Color(0xFF56B9F0),
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF211EE1)),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                    ),

                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 85.0),
                        child: Text(
                          '${percentage.toStringAsFixed(0)}%',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text(
                  'Your Score',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Correct',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '$correctAnswers',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'Incorrect',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          '$incorrectAnswers',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {

                  },
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.red),
                  ),
                  child: Text(
                    'Refresh',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      child: Text(
                        'Home',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Add functionality for the review button
                      },
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      child: Text(
                        'Review',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  //
  // void _updatePercentage() {
  //   setState(() {
  //     percentage = Random().nextDouble() * 100;
  //   });
  // }
//
//   void _updateAnswers() {
//     int totalQuestions = 10;
//     int maxCorrectAnswers =
//         totalQuestions ~/ 2; // Maximum number of correct answers
//     int maxIncorrectAnswers = totalQuestions -
//         maxCorrectAnswers; // Maximum number of incorrect answers
//
//     int availableQuestions = totalQuestions; // Tracks the remaining questions
//
//     int correct = Random().nextInt(
//         maxCorrectAnswers + 1); // Random number up to maxCorrectAnswers
//     availableQuestions -= correct;
//
//     int incorrect = min(
//         availableQuestions,
//         Random().nextInt(maxIncorrectAnswers +
//             1)); // Random number up to maxIncorrectAnswers, but limited by remaining questions
//     availableQuestions -= incorrect;
//
//     // Assign remaining questions as correct or incorrect randomly
//     correct += availableQuestions;
//
//     setState(() {
//       correctAnswers = correct;
//       incorrectAnswers = incorrect;
//     });
//   }
 }
