

import 'dart:convert';

import 'package:app/LoginScreen.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

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
  String obj = result.toString();
  List<dynamic> dataList = jsonDecode(obj);


  for (var data in dataList) {
    List<String> options = List<String>.from(data['options']);
    print('Question: ${data['question']}');
    for (var option in options) {
      print('  - $option');
    }
  }

  // print(response.text);
}
}