class Project {
  final String title;
  final String description;
  final List<String> technologies;
  final String githubUrl;
  final String? imageUrl;

  const Project({
    required this.title,
    required this.description,
    required this.technologies,
    required this.githubUrl,
    this.imageUrl,
  });
}

// Sample projects (REPLACE WITH YOUR ACTUAL PROJECTS)
const List<Project> sampleProjects = [
  Project(
    title: 'E-Commerce Restaurant  App',
    description:'E-Commerce Restaurant App is a full-featured e-commerce application with product catalog, cart, and checkout functionality. Built with clean architecture and state management.',
    technologies: ['Flutter', 'Firebase', 'Bloc', 'REST API'],
    githubUrl: 'https://github.com/elshaarawy7/restaurant-app',
  ),
  Project(
    title: 'Rahhala',
    description:
        " Rihlat is an innovative travel management app designed to help you plan and organize your trips with ease." 
        "It offers a smooth user experience and a clean, modern design that keeps all your travel details in one place." 
        "With Rihlat, you’ll always be prepared for your journey — no stress, no forgetting, just smooth planning." 
        "✔ Simple and intuitive interface"
        "✔ Fast performance"
        "✔ Comfortable user experience"
        "Your journey starts here ✨," ,
        
    technologies: ['Flutter Web', 'Provider', 'Firebase', 'Material Design'],
    githubUrl: 'https://github.com/johndoe/task-dashboard',
  ),
  Project(
    title: 'Zestora-App',
    description:
        'Zestora-App is a full-featured e-commerce application with product catalog, cart, and checkout functionality. Built with clean architecture and state management.',
    technologies: ['Flutter', 'OpenWeather API', 'Riverpod', 'Animations'],
    githubUrl: 'https://github.com/elshaarawy7/Zestora-App',
  ),
  Project(
    title: 'Fitness Tracker',
    description:
        'Track workouts, set goals, and monitor progress. Includes charts, statistics, and workout history with local storage.',
    technologies: ['Flutter', 'Hive', 'Charts', 'Local Notifications'],
    githubUrl: 'https://github.com/johndoe/fitness-tracker',
  ),
  Project(
    title: 'storeApp',
    description:
        'storeApp is a full-featured e-commerce application with product catalog, cart, and checkout functionality. Built with clean architecture and state management.',
    technologies: ['Flutter', 'GraphQL', 'Bloc', 'Image Picker'],
    githubUrl: 'https://github.com/elshaarawy7/storeApp',
  ),
  
];
