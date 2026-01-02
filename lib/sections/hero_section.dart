import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:protofoluo/utils/app_theme.dart';
import 'package:protofoluo/utils/constants.dart';
import 'package:protofoluo/widgets/responsive_layout.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));

    // Start animations with delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _fadeController.forward();
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      constraints: const BoxConstraints(minHeight: 600),
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveLayout.getHorizontalPadding(context),
        vertical: AppTheme.spacingXXXL,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: ResponsiveLayout.getMaxWidth(context),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Animated name
                  if (ResponsiveLayout.isDesktop(context))
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          AppConstants.name,
                          textStyle: theme.textTheme.displayLarge?.copyWith(
                            color: isDark
                                ? AppTheme.darkSecondary
                                : AppTheme.lightSecondary,
                          ),
                          speed: const Duration(milliseconds: 100),
                        ),
                      ],
                      totalRepeatCount: 1,
                      pause: const Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                    )
                  else
                    Text(
                      AppConstants.name,
                      style: ResponsiveLayout.isMobile(context)
                          ? theme.textTheme.displaySmall
                          : theme.textTheme.displayMedium,
                    ),
                  const SizedBox(height: AppTheme.spacingM),

                  // Title
                  Text(
                    AppConstants.title,
                    style: ResponsiveLayout.isMobile(context)
                        ? theme.textTheme.headlineSmall
                        : theme.textTheme.headlineLarge,
                  ),
                  const SizedBox(height: AppTheme.spacingL),

                  // Tagline
                  Text(
                    AppConstants.tagline,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: isDark
                          ? AppTheme.darkSecondary
                          : AppTheme.lightSecondary,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacingXL),

                  // CTA Buttons
                  Wrap(
                    spacing: AppTheme.spacingM,
                    runSpacing: AppTheme.spacingM,
                    children: [
                      _CTAButton(
                        label: 'View Projects',
                        isPrimary: true,
                        onPressed: () {},
                      ),
                      _CTAButton(
                        label: 'Contact Me',
                        isPrimary: false,
                        onPressed: () {},
                      ),
                    ],
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

class _CTAButton extends StatefulWidget {
  final String label;
  final bool isPrimary;
  final VoidCallback onPressed;

  const _CTAButton({
    required this.label,
    required this.isPrimary,
    required this.onPressed,
  });

  @override
  State<_CTAButton> createState() => _CTAButtonState();
}

class _CTAButtonState extends State<_CTAButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        scale: _isHovered ? 1.05 : 1.0,
        duration: AppTheme.fastAnimation,
        child: widget.isPrimary
            ? ElevatedButton(
                onPressed: widget.onPressed,
                child: Text(widget.label),
              )
            : OutlinedButton(
                onPressed: widget.onPressed,
                child: Text(widget.label),
              ),
      ),
    );
  }
}
