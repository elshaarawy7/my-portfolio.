import 'package:flutter/material.dart';

class Skill {
  final String name;
  final IconData icon;
  final String category;

  const Skill({required this.name, required this.icon, required this.category});
}

// Sample skills (REPLACE WITH YOUR ACTUAL SKILLS)
const List<Skill> sampleSkills = [
  // Languages
  Skill(name: 'Dart', icon: Icons.code, category: 'Languages'),
  Skill(name: 'Java', icon: Icons.code, category: 'Languages'),
  Skill(name: 'c++', icon: Icons.code, category: 'Languages'),


  // Frameworks & Libraries
  Skill(name: 'Flutter', icon: Icons.flutter_dash, category: 'Frameworks'),
  Skill(name: 'html', icon: Icons.web, category: 'Frameworks'),
  Skill(name: 'css', icon: Icons.dns, category: 'Frameworks'),
  Skill(name: 'Firebase', icon: Icons.cloud, category: 'Frameworks'),

  // Tools & Others
  Skill(name: 'Git', icon: Icons.source, category: 'Tools'),
  Skill(name: 'Github', icon: Icons.api, category: 'Tools'),
  Skill(name: 'sqlite', icon: Icons.graphic_eq, category: 'Tools'),
  Skill(name: 'Postman', icon: Icons.design_services, category: 'Tools'),
  Skill(name: 'Docker', icon: Icons.inventory_2, category: 'Tools'),

];
