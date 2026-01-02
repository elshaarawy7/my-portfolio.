import 'package:flutter/material.dart';
import 'package:protofoluo/models/course.dart';
import 'package:protofoluo/sections/about_section.dart';
import 'package:protofoluo/utils/app_theme.dart';
import 'package:protofoluo/widgets/course_card.dart';
import 'package:protofoluo/widgets/responsive_layout.dart';

class CoursesSection extends StatefulWidget {
  const CoursesSection({super.key});

  @override
  State<CoursesSection> createState() => _CoursesSectionState();
}

class _CoursesSectionState extends State<CoursesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = false;
  final List<Animation<double>> _itemAnimations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Create staggered animations for each course
    for (int i = 0; i < sampleCourses.length; i++) {
      final start = (i * 0.1).clamp(0.0, 0.5);
      final end = (start + 0.5).clamp(0.0, 1.0);
      _itemAnimations.add(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkVisibility() {
    if (!_isVisible) {
      setState(() => _isVisible = true);
      _controller.forward();
    }
  }

  int _getCrossAxisCount(BuildContext context) {
    if (ResponsiveLayout.isMobile(context)) return 1;
    if (ResponsiveLayout.isTablet(context)) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return VisibilityDetector(
      onVisibilityChanged: (visible) {
        if (visible) _checkVisibility();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveLayout.getHorizontalPadding(context),
          vertical: AppTheme.spacingXXL,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: ResponsiveLayout.getMaxWidth(context),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Courses & Certificates',
                  style: ResponsiveLayout.isMobile(context)
                      ? theme.textTheme.displaySmall
                      : theme.textTheme.displayMedium,
                ),
                const SizedBox(height: AppTheme.spacingXL),

                // Courses grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context),
                    crossAxisSpacing: AppTheme.spacingL,
                    mainAxisSpacing: AppTheme.spacingL,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: sampleCourses.length,
                  itemBuilder: (context, index) {
                    return FadeTransition(
                      opacity: _itemAnimations[index],
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(_itemAnimations[index]),
                        child: CourseCard(
                          course: sampleCourses[index],
                          index: index,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

