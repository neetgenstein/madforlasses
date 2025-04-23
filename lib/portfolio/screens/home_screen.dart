import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text(
            '👋 Welcome to My Portfolio!',
            style: TextStyle(fontSize: 22),
          ),
        ),
      ],
    );
  }
}
