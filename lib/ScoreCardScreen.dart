//
// import 'package:flutter/material.dart';
// import 'HomeScreen.dart';
// import 'dart:async';
// import 'dart:math';
//
//
// class Scoreboard extends StatefulWidget {
//
//   final List<int> myList;
//
//   Scoreboard(this.myList);
//
//   @override
//   _ScoreboardState createState() => _ScoreboardState(myList);
// }
//
// class _ScoreboardState extends State<Scoreboard> {
//   final List<int> myList;
//   _ScoreboardState(this.myList);
//   int correctAnswers = 0;
//   int incorrectAnswers = 0;
//   double percentage = 0.0;
//   int totalAnswers = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     for (int num in myList) {
//       totalAnswers++;
//       if (num == 1) {
//         correctAnswers++;
//       }
//     }
//      incorrectAnswers = totalAnswers - correctAnswers;
//      percentage = (correctAnswers/totalAnswers) * 100;
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: WillPopScope(
//         onWillPop: () async {
//           Navigator.of(context).pop();
//           return true;
//         },
//         child: Scaffold(
//           appBar: AppBar(
//             backgroundColor: Color(0xFF2BCAFF),
//             title: Text('Scoreboard'),
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           body: Center(
//
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Stack(
//                   children: [
//                     Center(
//                       child: AnimatedContainer(
//                         duration: Duration(seconds: 60),
//                         curve: Curves.easeInOut,
//                         width: 200,
//                         height: 200,
//                         child: CircularProgressIndicator(
//                           value: percentage / 100,
//                           strokeWidth: 15,
//                           backgroundColor: Color(0xFF56B9F0),
//                           valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF211EE1)),
//                           strokeCap: StrokeCap.round,
//                         ),
//                       ),
//                     ),
//
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 85.0),
//                         child: Text(
//                           '${percentage.toStringAsFixed(0)}%',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'Your Score',
//                   style: TextStyle(fontSize: 20),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           'Correct',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         Text(
//                           '$correctAnswers',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ],
//                     ),
//                     Column(
//                       children: [
//                         Text(
//                           'Incorrect',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                         Text(
//                           '$incorrectAnswers',
//                           style: TextStyle(fontSize: 20),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//
//                   },
//                   style: ButtonStyle(
//                     backgroundColor:
//                     MaterialStateProperty.all<Color>(Colors.red),
//                   ),
//                   child: Text(
//                     'Refresh',
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => HomeScreen()));
//                       },
//                       style: ButtonStyle(
//                         backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.blue),
//                       ),
//                       child: Text(
//                         'Home',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         // Add functionality for the review button
//                       },
//                       style: ButtonStyle(
//                         backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.green),
//                       ),
//                       child: Text(
//                         'Review',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
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
 //}

import 'package:app/HomeScreen.dart';
import 'package:flutter/material.dart';
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
  int totalAnswers = 0;
  double percentage = 0.0;
  List<int> correctIndices = [];
  List<int> incorrectIndices = [];

  @override

  Widget build(BuildContext context) {
    for(int num in myList) {
      totalAnswers++;
      if (num == 1) {
        correctAnswers++;
      }
    }
    incorrectAnswers = totalAnswers - correctAnswers;
    percentage = (correctAnswers/totalAnswers) * 100;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF38ECF8),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  children: [
                    Text(
                      'Scoreboard',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 0),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 600,
                width: 300,
                decoration: BoxDecoration(
                  color: Color(0xFF80F7FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                              width: 200,
                              height: 200,
                              child: CircularProgressIndicator(
                                value: percentage / 100,
                                strokeWidth: 15,
                                backgroundColor: Color(0xFF56B9F0),
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xFF211EE1),
                                ),
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                            Positioned(
                              top: 100.0,
                              child: Text(
                                '${percentage.toStringAsFixed(0)}%',
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 0),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'Your Score',
                        style: TextStyle(fontSize: 20),
                      ),
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
                        // _updateAnswers();
                        // _updatePercentage();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red,
                        ),
                      ),
                      child: Text(
                        'Refresh',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => HomeScreen()),
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.blue,
                              ),
                            ),
                            child: Text(
                              'Home',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                            //  _reviewAnswers(correctIndices, incorrectIndices);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green,
                              ),
                            ),
                            child: Text(
                              'Review',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updatePercentage() {
    int totalQuestions = correctAnswers + incorrectAnswers;
    double targetPercentage;
    if (totalQuestions > 0) {
      targetPercentage = (correctAnswers / totalQuestions) * 100;
    } else {
      targetPercentage = 0.0;
    }

    double step = 1;
    double currentPercentage = percentage;

    Timer.periodic(Duration(milliseconds: 20), (timer) {
      setState(() {
        if (currentPercentage < targetPercentage) {
          currentPercentage += step;
        } else {
          currentPercentage -= step;
        }

        percentage = currentPercentage;

        if (currentPercentage == targetPercentage) {
          timer.cancel();
        }
      });
    });
  }

  // void _updateAnswers() {
  //   int totalQuestions = 5;
  //
  //   correctIndices.clear();
  //   incorrectIndices.clear();
  //
  //   int correct = Random().nextInt(totalQuestions + 1);
  //   int incorrect = Random().nextInt(totalQuestions + 1);
  //
  //   if (correct + incorrect > totalQuestions) {
  //     int difference = (correct + incorrect) - totalQuestions;
  //     if (correct - difference >= 0) {
  //       correct -= difference;
  //     } else {
  //       incorrect -= difference;
  //     }
  //   }

    //
    // Let's distribute questions to correct and incorrect lists
    // for (int i = 0; i < correct; i++) {
    //   correctIndices.add(i + 1);
    // }
    // for (int i = correct; i < totalQuestions; i++) {
    //   incorrectIndices.add(i + 1);
    // }

    // setState(() {
    //   correctAnswers = correct;
    //   incorrectAnswers = incorrect;
    // });

   // _updatePercentage();
  }
//
//   void _reviewAnswers(List<int> correctIndices, List<int> incorrectIndices) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ReviewScreen(
//           correctIndices: correctIndices,
//           incorrectIndices: incorrectIndices,
//         ),
//       ),
//     );
//   }
// }

// class ReviewScreen extends StatelessWidget {
//   final List<int> correctIndices;
//   final List<int> incorrectIndices;
//
//   ReviewScreen({required this.correctIndices, required this.incorrectIndices});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Review'),
//       ),
//       body: DefaultTabController(
//         length: 2,
//         child: Column(
//           children: [
//             TabBar(
//               tabs: [
//                 Tab(text: 'Correct'),
//                 Tab(text: 'Incorrect'),
//               ],
//               indicatorColor: Colors.blue,
//               labelColor: Colors.blue,
//               unselectedLabelColor: Colors.black,
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   _buildReviewList(correctIndices),
//                   _buildReviewList(incorrectIndices),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildReviewList(List<int> indices) {
//     return ListView.builder(
//       itemCount: indices.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text('Question ${indices[index]}'),
//           subtitle: Text('Option: ${_generateOption(indices[index])}'),
//         );
//       },
//     );
//   }
//
//   String _generateOption(int questionNumber) {
//     // Here you can replace this logic with your own logic to generate options
//     // For now, let's generate a random option (A, B, C, D)
//     List<String> options = ['A', 'B', 'C', 'D'];
//     return options[Random().nextInt(options.length)];
//   }
// }
