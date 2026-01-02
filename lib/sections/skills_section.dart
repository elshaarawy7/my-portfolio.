import 'package:flutter/material.dart';
import 'package:protofoluo/models/skill.dart';
import 'package:protofoluo/sections/about_section.dart';
import 'package:protofoluo/utils/app_theme.dart';
import 'package:protofoluo/widgets/responsive_layout.dart';
import 'package:protofoluo/widgets/skill_chip.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _isVisible = false;
  final List<Animation<double>> _itemAnimations = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Create staggered animations for each skill
    for (int i = 0; i < sampleSkills.length; i++) {
      final start = (i * 0.05).clamp(0.0, 0.6);
      final end = (start + 0.4).clamp(0.0, 1.0);
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Group skills by category
    final skillsByCategory = <String, List<Skill>>{};
    for (final skill in sampleSkills) {
      skillsByCategory.putIfAbsent(skill.category, () => []).add(skill);
    }

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
                  'Skills',
                  style: ResponsiveLayout.isMobile(context)
                      ? theme.textTheme.displaySmall
                      : theme.textTheme.displayMedium,
                ),
                const SizedBox(height: AppTheme.spacingXL),

                // Skills grid
                Wrap(
                  spacing: AppTheme.spacingM,
                  runSpacing: AppTheme.spacingM,
                  children: List.generate(
                    sampleSkills.length,
                    (index) => FadeTransition(
                      opacity: _itemAnimations[index],
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.3),
                          end: Offset.zero,
                        ).animate(_itemAnimations[index]),
                        child: SkillChip(skill: sampleSkills[index]),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
