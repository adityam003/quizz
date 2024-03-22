import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ScoreCardScreen.dart';
import 'save_file_mobile_and_desktop.dart'
if (dart.library.html) 'save_file_web.dart';




class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> question1 = {};
  Map<String, dynamic> question2 = {};
  Map<String, dynamic> question3 = {};
  Map<String, dynamic> question4 = {};
  Map<String, dynamic> question5 = {};
  List<int> myList = List<int>.filled(5, 0);
  @override
  void initState() {
    super.initState();
    _generateQuestion(); // Call generateQuestion on initialization
  }

  Widget build(BuildContext context) {

    return Scaffold(
    backgroundColor: Color(0xFF2BCAFF),
    appBar: AppBar(
    backgroundColor: Color(0xFF2BCAFF),
    title: Center(child: Text("Quizzlet",
    style: GoogleFonts.suezOne(fontSize:30),)
    )
    ),
    body: Center(
      child: Column(
          children: [
            TextButton(onPressed: () => _ScreenNav(
              context,
              MyNextScreen(
                context: context,
                question1: question1,
                question2: question2,
                question3: question3,
                question4: question4,
                question5: question5,
                myList: myList,
              ),

                ),
                child: Text(
    'Question',
    style: TextStyle(color: Colors.white),
    ),
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith(
    (states) => Colors.blue)),
            ),
          ],
      ),


    )



    );
  }


  Future<String> _extractTextFromPDF() async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if(result!= null) {
      print(result.files.first.name);

      final file = File(result.files.first.path!);

      // Read the bytes
      final bytes = await file.readAsBytes();

      print(file);
      // file == OpenAppFile.open(file.path.toString());

      //Load the PDF document.
      // final PdfDocument document =
      // PdfDocument(inputBytes: await _readDocumentData(result.files.first.bytes));
      PdfDocument document = PdfDocument(inputBytes: bytes);
      //Create PDF text extractor to extract text.

      PdfTextExtractor extractor = PdfTextExtractor(document);

      //Extract text.
      String text = extractor.extractText();
      if(text!= '') {
        print('text is read');
      }
      else
        print("Nothing is read");
      // Dispose the document.
      document.dispose();
      return text;
      //Save the file and launch/download.
      //   SaveFile.saveAndLaunchFile(text, 'output.txt');
    }
    else
      return "unsuccessful";
  }

  Future<void> _ScreenNav(BuildContext context, Widget nextScreen) async {
    // Navigate to a new screen using Navigator.push
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }




  Future<void> _generateQuestion() async {
    // Access your API key as an environment variable (see "Set up your API key" above)
    const String apiKey = String.fromEnvironment('TMDB_KEY');
    if (apiKey == '') {
      print('No \$API_KEY environment variable');
      exit(1);
    }
    // For text-only input, use the gemini-pro model
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    const String prompt = '''from the given input create 5 questions in json and give 4 mcq type options for each question and answer in json(strictly follow the pattern and no extra word or character and start with square bracket directly no back ticks) following is the pattern
  [{
    "question": "Which of the following is a major river in India?",
    "options": [
      "Ganges",
      "Nile",
      "Amazon",
      "Mississippi"
    ],
    "answer": "Ganges"
  },
{
  "question": "Which city is the capital of India?",
  "options": [
  "Mumbai",
  "New Delhi",
  "Kolkata",
  "Chennai"
  ],
  "answer": "New Delhi"
  },
  ]''';
    String input =  await _extractTextFromPDF();
    final content = [Content.text(prompt + input)];
    final response = await model.generateContent(content);
    final result = response.text;
    String obj = result.toString();
    List<dynamic> dataList = jsonDecode(obj);


    for (var data in dataList) {
      List<String> options = List<String>.from(data['options']);
      print('Question: ${data['question']}');
      for (var option in options) {
        print('  - $option');
      }
    }

    question1 = dataList[0];
    question2 = dataList[1];
    question3 = dataList[2];
    question4 = dataList[3];
    question5 = dataList[4];
  }
}

class FinalScreen extends StatelessWidget {
  final String text;
  final List<int> myList;

  FinalScreen(this.text, this.myList);

  int totalCount = 0;

  @override
  Widget build(BuildContext context) {
    for (int num in myList) {
      if (num == 1) {
        totalCount++;
      }
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey[100], // Set background color
      appBar: AppBar(
        title: Text('Final Screen'), // Customize app bar title
        backgroundColor: Colors.blue, // Set app bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black), // Customize text style
            ),
            SizedBox(height: 20), // Add spacing between widgets
            Text(
              'Total Correct: $totalCount',
              style: TextStyle(fontSize: 20, color: Colors.black87), // Customize text style
            ),
          ],
        ),
      ),
    );
  }
}



class MyNextScreen extends StatelessWidget {
  final Map<String, dynamic> question1;
  final Map<String, dynamic> question2;
  final Map<String, dynamic> question3;
  final Map<String, dynamic> question4;
  final Map<String, dynamic> question5;
  final List<int> myList;
  final BuildContext context;

  const MyNextScreen({
    Key? key,
    required this.context,
    required this.question1,
    required this.question2,
    required this.question3,
    required this.question4,
    required this.question5,
    required this.myList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 5,
        child: Scaffold(
          body: Column(
            children: [

              SizedBox(height: 40), // Adjust this height as per your requirement
              TabBar(
                tabs: [
                  Tab(text: "1"),
                  Tab(text: "2"),
                  Tab(text: "3"),
                  Tab(text: "4"),
                  Tab(text: "5"),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildTabContent(1, question1),
                    _buildTabContent(2, question2),
                    _buildTabContent(3, question3),
                    _buildTabContent(4, question4),
                    _buildTabContent(5, question5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }





  Widget _buildTabContent(int number, Map<String, dynamic> dataList) {
    String question = dataList['question'];
    List<dynamic> options = dataList['options'];
    String answer = dataList['answer'];

    String selectedOption; // Variable to store the selected option

    // Function to handle the user's selection of an option
    void handleOptionSelection(String selectedOption, int num) {
      // Check if selected option is correct
      int index = num - 1; // Adjust num to get the correct index
      if (selectedOption == answer) {
        if (index >= 0 && index < myList.length) { // Check if index is valid
          myList[index] = 1;
          print("Correct!");
        }
      } else {
        if (index >= 0 && index < myList.length) { // Check if index is valid
          myList[index] = 0;
          print("Incorrect!");
        }
      }
    }

    String colorString;
    if(number == 1){
      colorString = '0xFF8BFF8F';
    } else if(number == 2) {
      colorString = '0xFFCC78FF';
    }else if(number == 3) {
      colorString = '0xFF38B3F8';
    }else if(number == 4) {
      colorString = '0xFFFFE662';
    }else{
      colorString = '0xFFFF5151';
    }
    Color color = Color(int.parse(colorString)); // Convert string to color


    return Container(
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      color: color, // Set background color here
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20), // Add margin between TabBar and question
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$question",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, // Set fontWeight to bold
                  ),
                ),
              ),
              SizedBox(height: 50), // Increase margin between question and options
              Column( // Nested Column for options
                children: options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        // Set the selected option
                        selectedOption = option.toString();
                        // Call the function to handle option selection
                        handleOptionSelection(selectedOption, number);
                      },
                      child: SizedBox( // Wrap Text with SizedBox
                        width: double.infinity, // Set width to match parent
                        child: Container(
                          margin: EdgeInsets.only(left: 12), // Add left margin of 30
                          child: Text(
                            option.toString(),
                            textAlign: TextAlign.left, // Align text to the left
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 40), // Set minimum height
                        padding: EdgeInsets.symmetric(horizontal: 10), // Reduce padding
                        shape: RoundedRectangleBorder( // Rounded corners for box-like appearance
                          borderRadius: BorderRadius.circular(15.0), // Adjust corner radius
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          if (number == 5)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(), // Add an empty SizedBox to push the options to the top
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle submit button tap
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Scoreboard(myList),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10), // Adjust button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30), // Set button border radius
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 20, // Set font size
                          fontWeight: FontWeight.bold, // Set font weight to bold
                          color: Colors.white, // Set text color to white
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 0), // Add space below the button
                ],

              ),
            ),
        ],
      ),
    );

  }


}