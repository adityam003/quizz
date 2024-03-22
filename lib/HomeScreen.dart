import  'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'QuizScreen.dart';
import 'ProfileScreen.dart';
import 'ChatBot.dart';


class HomeScreen extends StatelessWidget{
  HomeScreen();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     backgroundColor: Color(0xFF2BCAFF),
     appBar: AppBar(
       backgroundColor: Color(0xFF2BCAFF),
     title: Center(child: Text("Quizzlet",
     style: GoogleFonts.suezOne(fontSize:30),)
     )
     ),
       drawer: Drawer(
         backgroundColor: Color(0xFF2BCAFF),
       child: ListView(
       padding: EdgeInsets.zero,
       children: <Widget>[
       Container(
       height: 150, // Set the desired height for the custom header
       color: Color(0xFF2BCAFF), // Set the background color
       child: Center(
         child: Row(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             SizedBox(width: 20), // Adjust the spacing as needed
             Icon(
               Icons.handshake, // Add handshake icon
               size: 40, // Adjust size as needed
               color: Colors.white, // Set icon color
             ),
             SizedBox(width: 10), // Add some space between the icon and text
             Text(
               'Welcome',
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 24,
               ),
             ),
           ],
         ),
       ),
       ),
       ],
   ),
       ),
       bottomNavigationBar: SafeArea(

       child: Container(
         height: 56,
         padding: EdgeInsets.all(20),
         margin: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
         decoration: BoxDecoration(color:Color(0xFF44BCFF),
         borderRadius: BorderRadius.all(Radius.circular(20)),
         boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.3),
             offset: Offset(0,20),
             blurRadius: 20,
         )
             ]),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                IconButton(
                  onPressed: (){},
                icon: Icon(Icons.grid_view_rounded),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                ),
                  IconButton(
                  onPressed: (){},
                icon: Icon(Icons.quiz),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                ),
                  IconButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chatbot()));
                  },
                icon: Icon(Icons.chat),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 12),
                ),


                IconButton(
                  onPressed:(){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen()));
                  } ,
                  icon: Icon(Icons.person),
                padding: EdgeInsets.fromLTRB(0,0,0,12),
       )
              ],
              )

       ),),
       body: Center(

       child: Column(
       //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [

           Align(
             alignment: Alignment.topLeft,
           child: Padding(
             padding: EdgeInsets.fromLTRB(13, 20, 0, 0),
            child: Text("Fly Towards Your\nLearning\nJourney",
           style: GoogleFonts.suezOne(fontSize:24,
             color: Color(0xFF433C3C),

           ),
            )
           )
           ),
           Align(
             alignment: Alignment.center,
             child: Lottie.asset("assets/paperairplane.json",
               fit: BoxFit.fill,
               repeat: true,
               frameRate: FrameRate.max,
               width:1000,
             )


           ),

         Align(
           alignment: FractionalOffset(0.5,0.3),
         child: Text(
           "Upload your file",
           style: GoogleFonts.stylish(fontSize:20),
           textAlign: TextAlign.end,

         ),

         ),
          TextButton(onPressed: (){

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(title: "aditya"))
            );


          },
          child: Text("Upload",
          style: GoogleFonts.inter(fontSize:12,
          fontWeight: FontWeight.bold,
          color: Colors.white),),
            style:TextButton.styleFrom(
              backgroundColor: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15)
            ),
          ),
//            SizedBox(height:20),
//            Expanded(
//              child: Stack(
//                children: [
//                Container(
//                width: double.infinity,
//                height: double.infinity,
//                child: Image.asset(
//                  'assets/wave.png',
//                  fit: BoxFit.cover,
//                ),
//              ),
// ]
//           ),
 //      )
         ]
       ),
   )
   );
  }

}