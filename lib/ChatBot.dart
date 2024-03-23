import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Chatbot extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatbot Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _controller = TextEditingController();
  List<String> _messages = [];
  String systemInput = "Your name is aditya";
  String character = "Bot";

  Future<String> sendMessage(String userMessage, String systemInput) async {
    final url = 'https://api.openai.com/v1/chat/completions';
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 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', // Replace with your API key
    };
    final body = json.encode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "system", "content": systemInput},
        {"role": "user", "content": userMessage}
      ],
      "max_tokens": 50
    });

    final response = await http.post(Uri.parse(url), headers: headers, body: body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final botMessage = jsonResponse['choices'][0]['message']['content'];
      return botMessage;
    } else {
      throw Exception('Failed to send message');
    }
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    // Get system input (you can replace this with any system input you want)


    setState(() {
      _messages.add('You: ${_controller.text}');
    });

    String botResponse = await sendMessage(_controller.text, systemInput);
    print('$character: $botResponse'); // Print bot response to console

    setState(() {
      _messages.add('$character: $botResponse');
    });

    _controller.clear();
  }

  void Superselect(String s) {

    if (s == 'A') {
      systemInput = 'Your Name is Albert Einstein and play the role of him and explain and give responses as him and here is the context';
      character = "Einstein";

    } else if (s == 'T') {
      systemInput = 'Your name is Tesla and play the role of him and explain and give responses as him';
      character = "Tesla";
    } else if (s == 'M') {
      systemInput = 'Your name is Marie Curie and play the role of her and explain and give responses as her';
      character = "Marie Curie";
    } else if (s == 'a') {
      systemInput = 'Your name is Isaac Newton and play the role of him and explain and give responses as him';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // automaticallyImplyLeading: true,
        title: Text('Chatbot Demo'),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(100), // Adjust the height as needed
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      Superselect('A');
                    },
                    child: Text('Einstein'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Superselect('T');
                    },
                    child: Text('Tesla'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Superselect('M');
                    },
                    child: Text('Curie'),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Superselect('a');
                  //   },
                  //   child: Text('Isaac Newton'),
                 // ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          SizedBox(height: 20), // Add some space between the buttons and text input
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}