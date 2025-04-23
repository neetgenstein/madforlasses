import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MaterialApp(home: FileExample()));
}

class FileExample extends StatefulWidget {
  @override
  _FileExampleState createState() => _FileExampleState();
}

class _FileExampleState extends State<FileExample> {
  TextEditingController _controller = TextEditingController();
  String _savedText = "";

  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/myfile.txt";
  }

  Future<void> _saveToFile(String text) async {
    final path = await _getFilePath();
    final file = File(path);
    await file.writeAsString(text);
  }

  Future<void> _readFromFile() async {
    try {
      final path = await _getFilePath();
      final file = File(path);
      String contents = await file.readAsString();
      setState(() {
        _savedText = contents;
      });
    } catch (e) {
      setState(() {
        _savedText = "File not found!";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _readFromFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Read/Write File Example")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text("Saved content: $_savedText"),
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Enter text"),
            ),
            ElevatedButton(
              onPressed: () async {
                await _saveToFile(_controller.text);
                await _readFromFile();
              },
              child: Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
