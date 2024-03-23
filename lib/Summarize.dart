import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/material.dart';

class Summarize extends StatefulWidget {
  final String geminiText;

  const Summarize({required this.geminiText});

  @override
  _SummarizeState createState() => _SummarizeState();
}

class _SummarizeState extends State<Summarize> {
  String summary = 'Summary loading...';

  @override
  void initState() {
    super.initState();
    generateSummary(widget.geminiText);
  }

  Future<void> generateSummary(String input) async {
    const String apiKey = String.fromEnvironment('TMDB_KEY');
    if (apiKey == '') {
      print('No \$API_KEY environment variable');
      // exit(1);
    }
    // For text-only input, use the gemini-pro model
    final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
    const String prompt = "Make a short entertaining and pointwise Summary of the following input";
    final content = [Content.text(prompt + input)];
    final response = await model.generateContent(content);

    setState(() {
      summary = response.text.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF2BCAFF),
        title: Center(child: Text("Too Long.. Didn't Read",
        style: GoogleFonts.inter(fontSize:20,fontWeight: FontWeight.bold),)),
      ),
      backgroundColor: Color(0xFF2BCAFF),
      body: SingleChildScrollView(

        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20),
           child: Text(summary,
            style: GoogleFonts.inter(fontSize:14,fontWeight:FontWeight.bold,color: Colors.black),
           ),
      ),
          ],

        ),
      ),
    );
  }
}
