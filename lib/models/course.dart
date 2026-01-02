import 'package:flutter/material.dart';

class Course {
  final String title;
  final String provider;
  final String? certificateUrl;
  final String? date;
  final String? description;
  final IconData? icon;

  const Course({
    required this.title,
    required this.provider,
    this.certificateUrl,
    this.date,
    this.description,
    this.icon,
  });
}

// Sample courses and certificates (REPLACE WITH YOUR ACTUAL COURSES)
const List<Course> sampleCourses = [ 
  Course(
    title: 'Complete Flutter & Dart Development Course',
    provider: 'Udemy',
    date: '2024',
    description: 'Comprehensive course covering Flutter and Dart from basics to advanced level. Learn to build cross-platform mobile applications with modern UI/UX design patterns.',
    certificateUrl: 'https://www.udemy.com/course/mastering-programming-a-comprehensive-course-in-arabic/learn/lecture/38183738?start=0#overview',
    icon: Icons.flutter_dash,
  ),
  Course(
    title: 'Complete Flutter & Dart Development Course',
    provider: 'Udemy',
    date: '2024',
    description: 'Best and complete Flutter course for beginners. Master Dart programming language fundamentals and build real-world mobile applications step by step.',
    certificateUrl: 'https://www.udemy.com/course/best-and-complete-flutter-course-for-beginners/learn/lecture/30328714?start=0#overview',
    icon: Icons.flutter_dash,
  ),
  Course(
    title: 'Flutter Advanced Course Bloc and MVVM Pattern [Arabic]',
    provider: 'Udemy',
    date: '2025',
    description: 'Advanced Flutter development focusing on state management patterns. Master BLoC architecture and MVVM pattern to build scalable and maintainable applications.',
    certificateUrl: 'https://www.udemy.com/course/flutter-bloc-pattern-from-zero-to-hero-in-arabic/learn/lecture/33269198?start=0#overview',
    icon: Icons.cloud,
  ),
  Course(
    title: 'Flutter Clean Architecture Course',
    provider: 'Udemy',
    date: '2025',
    description: 'Deep dive into clean architecture principles in Flutter. Learn to structure your codebase using SOLID principles, dependency injection, and separation of concerns.',
    certificateUrl: 'https://www.udemy.com/course/deep-dive-into-clean-architecture-in-flutter-2022arabic/learn/lecture/38784074?start=0#overview',
    icon: Icons.code,
  ), 

  Course(
    title: 'Master Git & GitHub: Essential Skills for Developers[Arabic]',
    provider: 'Udemy',
    date: '2025',
    description: 'Master version control with Git and GitHub. Learn essential skills for managing code repositories, collaboration, branching strategies, and deployment workflows.',
    certificateUrl: "https://www.udemy.com/course/master-git-github-essential-skills-for-developersarabic/",
    icon: Icons.code,
  ), 


  Course(
    title: 'Flutter Payment Integration Course',
    provider: 'Udemy',
    date: '2025',
    description: 'Learn to integrate payment gateways in Flutter applications. Master Stripe, PayPal, and other payment methods to build secure e-commerce solutions.',
    certificateUrl: "https://www.udemy.com/course/flutter-payment-integration-stripe-paypal-more-arabic/learn/lecture/50692487?start=0#overview",
    icon: Icons.code,
  ), 

   Course(
    title: 'Data Structure Course',
    provider: 'learnsimply',
    date: '2025',
    description: 'Comprehensive course on data structures and algorithms using C++. Master arrays, linked lists, stacks, queues, trees, and graphs to solve complex programming problems.',
    certificateUrl: "https://learrnsimply.com/courses/data-structure-c/",
    icon: Icons.code,
  ),
];

