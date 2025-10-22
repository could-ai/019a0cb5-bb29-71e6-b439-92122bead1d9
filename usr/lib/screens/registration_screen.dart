import 'package:flutter/material.dart';
import '../services/student_service.dart';
import '../models/student.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentService = StudentService();

  String name = '';
  String bio = '';
  List<String> skills = [];
  String skillInput = '';
  List<Map<String, dynamic>> projects = [];
  String projectTitle = '';
  String projectDescription = '';
  List<String> projectTechnologies = [];
  String technologyInput = '';

  void _addSkill() {
    if (skillInput.isNotEmpty) {
      setState(() {
        skills.add(skillInput);
        skillInput = '';
      });
    }
  }

  void _addProject() {
    if (projectTitle.isNotEmpty && projectDescription.isNotEmpty) {
      setState(() {
        projects.add({
          'title': projectTitle,
          'description': projectDescription,
          'technologies': List<String>.from(projectTechnologies),
        });
        projectTitle = '';
        projectDescription = '';
        projectTechnologies.clear();
      });
    }
  }

  void _addTechnology() {
    if (technologyInput.isNotEmpty) {
      setState(() {
        projectTechnologies.add(technologyInput);
        technologyInput = '';
      });
    }
  }

  Future<void> _registerStudent() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newStudent = Student(
        name: name,
        bio: bio,
        skills: skills,
        projects: projects.map((p) => Project(
          title: p['title'],
          description: p['description'],
          technologies: p['technologies'],
        )).toList(),
      );
      await _studentService.addStudent(newStudent);
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Студент зарегистрирован!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация студента'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Имя'),
                validator: (value) => value!.isEmpty ? 'Введите имя' : null,
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Биография'),
                onSaved: (value) => bio = value ?? '',
              ),
              SizedBox(height: 16),
              Text('Навыки:', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Введите навык'),
                      onChanged: (value) => skillInput = value,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addSkill,
                  ),
                ],
              ),
              Wrap(
                children: skills.map((skill) => Chip(label: Text(skill))).toList(),
              ),
              SizedBox(height: 16),
              Text('Проекты:', style: TextStyle(fontWeight: FontWeight.bold)),
              TextFormField(
                decoration: InputDecoration(labelText: 'Название проекта'),
                onChanged: (value) => projectTitle = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Описание проекта'),
                onChanged: (value) => projectDescription = value,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(hintText: 'Технология'),
                      onChanged: (value) => technologyInput = value,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addTechnology,
                  ),
                ],
              ),
              Wrap(
                children: projectTechnologies.map((tech) => Chip(label: Text(tech))).toList(),
              ),
              ElevatedButton(
                onPressed: _addProject,
                child: Text('Добавить проект'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _registerStudent,
                child: Text('Зарегистрировать'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}