import 'package:flutter/material.dart';
import 'package:protofoluo/utils/app_theme.dart';
import 'package:protofoluo/utils/constants.dart';
import 'package:protofoluo/widgets/responsive_layout.dart';

class AboutSection extends StatefulWidget {
  const AboutSection({super.key});

  @override
  State<AboutSection> createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
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
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Me',
                    style: ResponsiveLayout.isMobile(context)
                        ? theme.textTheme.displaySmall
                        : theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: AppTheme.spacingXL),
                  Text(
                    AppConstants.aboutMe,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDark
                          ? AppTheme.darkSecondary
                          : AppTheme.lightSecondary,
                      height: 1.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Simple visibility detector widget
class VisibilityDetector extends StatefulWidget {
  final Widget child;
  final Function(bool) onVisibilityChanged;

  const VisibilityDetector({
    super.key,
    required this.child,
    required this.onVisibilityChanged,
  });

  @override
  State<VisibilityDetector> createState() => _VisibilityDetectorState();
}

class _VisibilityDetectorState extends State<VisibilityDetector> {
  bool _hasNotified = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Simple visibility check - trigger when widget is built
        if (!_hasNotified) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !_hasNotified) {
              _hasNotified = true;
              widget.onVisibilityChanged(true);
            }
          });
        }
        return widget.child;
      },
    );
  }
}
