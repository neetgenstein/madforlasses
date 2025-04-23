import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Text(
        'Hi, I\'m Alex — a Flutter developer passionate about building clean and efficient apps.',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
