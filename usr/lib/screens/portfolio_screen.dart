import 'package:flutter/material.dart';
import '../models/student.dart';

class PortfolioScreen extends StatelessWidget {
  final Student student;

  const PortfolioScreen({Key? key, required this.student}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Портфолио ${student.name}'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              student.name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              student.bio,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Навыки:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Wrap(
              children: student.skills.map((skill) => Chip(label: Text(skill))).toList(),
            ),
            SizedBox(height: 16),
            Text(
              'Проекты:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ...student.projects.map((project) => Card(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(project.description),
                    SizedBox(height: 8),
                    Text('Технологии: ${project.technologies.join(', ')}'),
                  ],
                ),
              ),
            )).toList(),
          ],
        ),
      ),
    );
  }
}