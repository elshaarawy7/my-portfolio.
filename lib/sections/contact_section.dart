import 'package:flutter/material.dart';
import 'package:protofoluo/sections/about_section.dart';
import 'package:protofoluo/utils/app_theme.dart';
import 'package:protofoluo/utils/constants.dart';
import 'package:protofoluo/widgets/responsive_layout.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection>
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

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _launchEmail() async {
    final uri = Uri(scheme: 'mailto', path: AppConstants.email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
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
        decoration: BoxDecoration(
          color: isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
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
                    'Get In Touch',
                    style: ResponsiveLayout.isMobile(context)
                        ? theme.textTheme.displaySmall
                        : theme.textTheme.displayMedium,
                  ),
                  const SizedBox(height: AppTheme.spacingXL),

                  Text(
                    'Feel free to reach out for collaborations or just a friendly hello',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDark
                          ? AppTheme.darkSecondary
                          : AppTheme.lightSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXL),

                  // Email
                  _ContactItem(
                    icon: Icons.email_outlined,
                    label: AppConstants.email,
                    onTap: _launchEmail,
                  ),
                  const SizedBox(height: AppTheme.spacingM),

                  // Social links
                  Wrap(
                    spacing: AppTheme.spacingM,
                    runSpacing: AppTheme.spacingM,
                    children: [
                      _SocialButton(
                        icon: Icons.code,
                        label: 'GitHub',
                        onPressed: () => _launchUrl(AppConstants.github),
                      ),
                      _SocialButton(
                        icon: Icons.work_outline,
                        label: 'LinkedIn',
                        onPressed: () => _launchUrl(AppConstants.linkedin),
                      ),
                     
                    ],
                  ),
                  const SizedBox(height: AppTheme.spacingXXL),

                  // Footer
                  Center(
                    child: Text(
                      '© ${DateTime.now().year} ${AppConstants.name}. Built with Flutter.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark
                            ? AppTheme.darkSecondary
                            : AppTheme.lightSecondary,
                      ),
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

class _ContactItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ContactItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  State<_ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<_ContactItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppTheme.fastAnimation,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                color: _isHovered
                    ? (isDark ? AppTheme.darkAccent : AppTheme.lightAccent)
                    : theme.iconTheme.color,
              ),
              const SizedBox(width: AppTheme.spacingS),
              Text(
                widget.label,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: _isHovered
                      ? (isDark ? AppTheme.darkAccent : AppTheme.lightAccent)
                      : null,
                  decoration: _isHovered ? TextDecoration.underline : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: AppTheme.fastAnimation,
        child: OutlinedButton.icon(
          onPressed: widget.onPressed,
          icon: Icon(widget.icon, size: 18),
          label: Text(widget.label),
        ),
      ),
    );
  }
}
