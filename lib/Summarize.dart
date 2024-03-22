import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter/material.dart';

class Summarize extends StatelessWidget{
  String GeminiText ;
  Summarize({required this.GeminiText});
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Center(child: Text("Too Long.. Didn't Read"),),
     ),
     body: Center(
       child: Column(
         children: [
            Text("")
         ],
       ),
     ),

   );

  }

}