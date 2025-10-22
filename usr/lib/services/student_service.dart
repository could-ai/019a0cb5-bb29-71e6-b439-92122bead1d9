import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/student.dart';

class StudentService {
  static const String _studentsKey = 'students';

  Future<List<Student>> loadStudents(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final String? studentsJson = prefs.getString(_studentsKey);
    if (studentsJson != null) {
      final List<dynamic> studentsData = json.decode(studentsJson);
      return studentsData.map((data) => Student.fromJson(data)).toList();
    } else {
      // Загружаем начальные данные из assets
      final String initialData = await DefaultAssetBundle.of(context)
          .loadString('assets/students.json');
      final List<dynamic> studentsData = json.decode(initialData);
      final students = studentsData.map((data) => Student.fromJson(data)).toList();
      // Сохраняем в SharedPreferences
      await saveStudents(students);
      return students;
    }
  }

  Future<void> saveStudents(List<Student> students) async {
    final prefs = await SharedPreferences.getInstance();
    final String studentsJson = json.encode(students.map((s) => s.toJson()).toList());
    await prefs.setString(_studentsKey, studentsJson);
  }

  Future<void> addStudent(BuildContext context, Student student) async {
    final students = await loadStudents(context);
    students.add(student);
    await saveStudents(students);
  }

  List<Student> searchStudents(List<Student> students, String query) {
    return students.where((student) => 
      student.name.toLowerCase().contains(query.toLowerCase())).toList();
  }
}