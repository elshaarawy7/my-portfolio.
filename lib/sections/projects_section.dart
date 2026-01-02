import 'package:flutter/material.dart';
import 'package:protofoluo/models/project.dart';
import 'package:protofoluo/sections/about_section.dart';
import 'package:protofoluo/utils/app_theme.dart';
import 'package:protofoluo/widgets/project_card.dart';
import 'package:protofoluo/widgets/responsive_layout.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection>
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

    // Create staggered animations for each project
    for (int i = 0; i < sampleProjects.length; i++) {
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

    return VisibilityDetector(
      onVisibilityChanged: (visible) {
        if (visible) _checkVisibility();
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveLayout.getHorizontalPadding(context),
          vertical: AppTheme.spacingXXL,
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
                  'Projects',
                  style: ResponsiveLayout.isMobile(context)
                      ? theme.textTheme.displaySmall
                      : theme.textTheme.displayMedium,
                ),
                const SizedBox(height: AppTheme.spacingXL),

                // Projects grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: _getCrossAxisCount(context),
                    crossAxisSpacing: AppTheme.spacingL,
                    mainAxisSpacing: AppTheme.spacingL,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: sampleProjects.length,
                  itemBuilder: (context, index) {
                    return FadeTransition(
                      opacity: _itemAnimations[index],
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(_itemAnimations[index]),
                        child: ProjectCard(
                          project: sampleProjects[index],
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
