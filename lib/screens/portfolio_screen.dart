import 'package:flutter/material.dart';
import 'package:protofoluo/providers/theme_provider.dart';
import 'package:protofoluo/sections/about_section.dart';
import 'package:protofoluo/sections/contact_section.dart';
import 'package:protofoluo/sections/courses_section.dart';
import 'package:protofoluo/sections/hero_section.dart';
import 'package:protofoluo/sections/projects_section.dart';
import 'package:protofoluo/sections/skills_section.dart';
import 'package:protofoluo/utils/constants.dart';
import 'package:protofoluo/widgets/nav_bar.dart';

class PortfolioScreen extends StatefulWidget {
  final ThemeProvider themeProvider;

  const PortfolioScreen({super.key, required this.themeProvider});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();
  final Map<String, GlobalKey> _sectionKeys = {
    AppConstants.heroSection: GlobalKey(),
    AppConstants.aboutSection: GlobalKey(),
    AppConstants.skillsSection: GlobalKey(),
    AppConstants.projectsSection: GlobalKey(),
    AppConstants.coursesSection: GlobalKey(),
    AppConstants.contactSection: GlobalKey(),
  };

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Add spacing for fixed navbar
                const SizedBox(height: 70),

                // Hero section
                Container(
                  key: _sectionKeys[AppConstants.heroSection],
                  child: const HeroSection(),
                ),

                // About section
                Container(
                  key: _sectionKeys[AppConstants.aboutSection],
                  child: const AboutSection(),
                ),

                // Skills section
                Container(
                  key: _sectionKeys[AppConstants.skillsSection],
                  child: const SkillsSection(),
                ),

                // Projects section
                Container(
                  key: _sectionKeys[AppConstants.projectsSection],
                  child: const ProjectsSection(),
                ),

                // Courses section
                Container(
                  key: _sectionKeys[AppConstants.coursesSection],
                  child: const CoursesSection(),
                ),

                // Contact section
                Container(
                  key: _sectionKeys[AppConstants.contactSection],
                  child: const ContactSection(),
                ),
              ],
            ),
          ),

          // Fixed navigation bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
              themeProvider: widget.themeProvider,
            ),
          ),
        ],
      ),
    );
  }
}
