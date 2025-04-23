import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('📧 Email: alex@example.com', style: TextStyle(fontSize: 16)),
          SizedBox(height: 10),
          Text(
            '🔗 LinkedIn: linkedin.com/in/alexdev',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            '💼 GitHub: github.com/alexportfolio',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
