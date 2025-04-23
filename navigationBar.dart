// main.dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Navigator Push Pop Demo', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String messageFromSecondPage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Go to Second Page"),
              onPressed: () async {
                // Push to SecondPage and wait for result
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );

                // If result is not null, update the message
                if (result != null) {
                  setState(() {
                    messageFromSecondPage = result;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              "Message from Second Page:\n$messageFromSecondPage",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  final String dataToReturn = "Hello from Second Page!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Second Page")),
      body: Center(
        child: ElevatedButton(
          child: Text("Go Back with Message"),
          onPressed: () {
            Navigator.pop(context, dataToReturn);
          },
        ),
      ),
    );
  }
}
