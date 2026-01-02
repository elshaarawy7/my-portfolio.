import 'package:flutter/material.dart';
import 'package:protofoluo/utils/app_theme.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    this.desktop,
  });

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppTheme.mobileBreakpoint;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppTheme.mobileBreakpoint &&
        width < AppTheme.desktopBreakpoint;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppTheme.desktopBreakpoint;
  }

  static double getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < AppTheme.mobileBreakpoint) {
      return AppTheme.spacingM;
    } else if (width < AppTheme.tabletBreakpoint) {
      return AppTheme.spacingXL;
    } else if (width < AppTheme.desktopBreakpoint) {
      return width * 0.08;
    } else {
      return width * 0.12;
    }
  }

  static double getMaxWidth(BuildContext context) {
    return 1200;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppTheme.desktopBreakpoint) {
          return desktop ?? tablet ?? mobile;
        } else if (constraints.maxWidth >= AppTheme.mobileBreakpoint) {
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
