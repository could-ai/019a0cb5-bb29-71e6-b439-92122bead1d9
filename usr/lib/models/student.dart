class Student {
  final String name;
  final String bio;
  final List<String> skills;
  final List<Project> projects;

  Student({
    required this.name,
    required this.bio,
    required this.skills,
    required this.projects,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      name: json['name'],
      bio: json['bio'],
      skills: List<String>.from(json['skills']),
      projects: (json['projects'] as List)
          .map((project) => Project.fromJson(project))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'bio': bio,
      'skills': skills,
      'projects': projects.map((project) => project.toJson()).toList(),
    };
  }
}

class Project {
  final String title;
  final String description;
  final List<String> technologies;

  Project({
    required this.title,
    required this.description,
    required this.technologies,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      title: json['title'],
      description: json['description'],
      technologies: List<String>.from(json['technologies']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'technologies': technologies,
    };
  }
}