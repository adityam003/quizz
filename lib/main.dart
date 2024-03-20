

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'save_file_mobile_and_desktop.dart'
if (dart.library.html) 'save_file_web.dart';



void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              child: Text(
                'Upload',
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.blue)),
              onPressed: _generateQuestion,
            )
          ],
        ),
      ),
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
Future<void> _generateQuestion() async{
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
  final obj = jsonEncode(result);
  final questions= jsonDecode(obj);
  // Arrays to store questions and options
  print(questions);
  //print('Question : ${questions['questions']}');

  // print(response.text);
}
}g