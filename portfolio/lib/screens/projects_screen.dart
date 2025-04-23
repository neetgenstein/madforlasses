import 'package:flutter/material.dart';

class ProjectsScreen extends StatelessWidget {
  final List<Map<String, String>> projects = [
    {'title': 'Weather App', 'description': 'Shows weather info using API'},
    {'title': 'Chat App', 'description': 'Realtime messaging with Firebase'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: projects.length,
      itemBuilder:
          (ctx, i) => Card(
            margin: EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(projects[i]['title']!),
              subtitle: Text(projects[i]['description']!),
            ),
          ),
    );
  }
}
