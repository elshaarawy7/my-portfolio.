import 'package:flutter/material.dart';
import 'package:protofoluo/models/course.dart';
import 'package:protofoluo/utils/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseCard extends StatefulWidget {
  final Course course;
  final int index;

  const CourseCard({super.key, required this.course, this.index = 0});

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AppTheme.fastAnimation,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _elevationAnimation = Tween<double>(
      begin: 0,
      end: 8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _elevationAnimation.value,
              child: Padding(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Icon and title row
                    Row(
                      children: [
                        if (widget.course.icon != null)
                          Container(
                            padding: const EdgeInsets.all(AppTheme.spacingS),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? AppTheme.darkAccent.withOpacity(0.1)
                                  : AppTheme.lightAccent.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              widget.course.icon,
                              color: isDark
                                  ? AppTheme.darkAccent
                                  : AppTheme.lightAccent,
                              size: 24,
                            ),
                          ),
                        if (widget.course.icon != null)
                          const SizedBox(width: AppTheme.spacingS),
                        Expanded(
                          child: Text(
                            widget.course.title,
                            style: theme.textTheme.titleLarge,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingS),

                    // Provider
                    Text(
                      widget.course.provider,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark
                            ? AppTheme.darkAccent
                            : AppTheme.lightAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: AppTheme.spacingS),

                    // Date if available
                    if (widget.course.date != null) ...[
                      Text(
                        widget.course.date!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppTheme.darkSecondary
                              : AppTheme.lightSecondary,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingS),
                    ],

                    // Description if available
                    if (widget.course.description != null) ...[
                      Expanded(
                        child: Text(
                          widget.course.description!,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: AppTheme.spacingM),
                    ],

                    // Certificate link button if available
                    if (widget.course.certificateUrl != null)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () =>
                              _launchUrl(widget.course.certificateUrl!),
                          icon: const Icon(Icons.verified, size: 18),
                          label: const Text('View Certificate'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: _isHovered
                                ? (isDark
                                      ? AppTheme.darkAccent
                                      : AppTheme.lightAccent)
                                : null,
                            side: BorderSide(
                              color: _isHovered
                                  ? (isDark
                                        ? AppTheme.darkAccent
                                        : AppTheme.lightAccent)
                                  : (isDark
                                        ? AppTheme.darkBorder
                                        : AppTheme.lightBorder),
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

