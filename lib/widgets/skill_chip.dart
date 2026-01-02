import 'package:flutter/material.dart';
import 'package:protofoluo/models/skill.dart';
import 'package:protofoluo/utils/app_theme.dart';

class SkillChip extends StatefulWidget {
  final Skill skill;

  const SkillChip({super.key, required this.skill});

  @override
  State<SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<SkillChip> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTheme.fastAnimation,
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingS,
          vertical: AppTheme.spacingXS,
        ),
        decoration: BoxDecoration(
          color: _isHovered
              ? (isDark
                    ? AppTheme.darkAccent.withOpacity(0.1)
                    : AppTheme.lightAccent.withOpacity(0.1))
              : Colors.transparent,
          border: Border.all(
            color: isDark ? AppTheme.darkBorder : AppTheme.lightBorder,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.skill.icon,
              size: 18,
              color: _isHovered
                  ? (isDark ? AppTheme.darkAccent : AppTheme.lightAccent)
                  : theme.textTheme.bodyMedium?.color,
            ),
            const SizedBox(width: AppTheme.spacingXS),
            Text(
              widget.skill.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _isHovered
                    ? (isDark ? AppTheme.darkAccent : AppTheme.lightAccent)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
