class AppConstants {
  // Portfolio information (REPLACE WITH YOUR ACTUAL INFO)
  static const String name = 'Elshaarawy Hassan';
  static const String title = 'Flutter Developer';
  static const String tagline =
      'Building beautiful, performant mobile & web applications';

  static const String aboutMe = '''
Hi, I'm Elshaarawy Hassan, a 21-year-old Computer Science student based in Cairo, Egypt. 
I am a passionate Flutter developer, focused on building modern, responsive mobile and web applications. 
I enjoy learning new technologies and improving my coding skills to deliver clean and efficient apps.

''';

  // Contact information (REPLACE WITH YOUR ACTUAL INFO)
  static const String email = 'elshaarawyhassan7@gmail.com';
  static const String github = 'https://github.com/elshaarawy7';
  static const String linkedin = 'https://www.linkedin.com/in/elshaarawy-hassan-6020002b6/';

  // Section keys for navigation
  static const String heroSection = 'hero';
  static const String aboutSection = 'about';
  static const String skillsSection = 'skills';
  static const String projectsSection = 'projects';
  static const String coursesSection = 'courses';
  static const String contactSection = 'contact';

  // Navigation items
  static const List<Map<String, String>> navItems = [
    {'label': 'About', 'section': aboutSection},
    {'label': 'Skills', 'section': skillsSection},
    {'label': 'Projects', 'section': projectsSection},
    {'label': 'Courses', 'section': coursesSection},
    {'label': 'Contact', 'section': contactSection},
  ];
}
