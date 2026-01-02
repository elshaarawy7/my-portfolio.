import 'package:flutter/material.dart';
import 'package:protofoluo/providers/theme_provider.dart';
import 'package:protofoluo/utils/app_theme.dart';

class ThemeToggleButton extends StatelessWidget {
  final ThemeProvider themeProvider;

  const ThemeToggleButton({super.key, required this.themeProvider});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => themeProvider.toggleTheme(),
      icon: AnimatedSwitcher(
        duration: AppTheme.mediumAnimation,
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: animation,
            child: FadeTransition(opacity: animation, child: child),
          );
        },
        child: Icon(
          themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
          key: ValueKey(themeProvider.isDarkMode),
        ),
      ),
      tooltip: themeProvider.isDarkMode ? 'Light mode' : 'Dark mode',
    );
  }
}
