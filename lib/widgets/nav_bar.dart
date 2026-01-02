import 'package:flutter/material.dart';
import 'package:protofoluo/providers/theme_provider.dart';
import 'package:protofoluo/utils/app_theme.dart';
import 'package:protofoluo/utils/constants.dart';
import 'package:protofoluo/widgets/responsive_layout.dart';
import 'package:protofoluo/widgets/theme_toggle_button.dart';

class NavBar extends StatefulWidget {
  final ScrollController scrollController;
  final Map<String, GlobalKey> sectionKeys;
  final ThemeProvider themeProvider;

  const NavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
    required this.themeProvider,
  });

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  String _activeSection = AppConstants.heroSection;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: AppTheme.slowAnimation,
      vsync: this,
    );

    _fadeAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  void _onScroll() {
    String newActiveSection = AppConstants.heroSection;

    for (final entry in widget.sectionKeys.entries) {
      final key = entry.value;
      final context = key.currentContext;

      if (context == null) continue;

      final box = context.findRenderObject() as RenderBox?;
      if (box == null) continue;

      final position = box.localToGlobal(Offset.zero).dy;

      if (position <= 100) {
        newActiveSection = entry.key;
      }
    }

    if (newActiveSection != _activeSection) {
      setState(() => _activeSection = newActiveSection);
    }
  }

  void _scrollToSection(String section) {
    final key = widget.sectionKeys[section];
    if (key == null) return;

    final context = key.currentContext;
    if (context == null) return;

    Scrollable.ensureVisible(
      context,
      duration: AppTheme.slowAnimation,
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: (isDark ? AppTheme.darkSurface : AppTheme.lightSurface)
              .withOpacity(0.9),
          border: Border(
            bottom: BorderSide(
              color: isDark
                  ? AppTheme.darkBorder
                  : AppTheme.lightBorder,
              width: 1,
            ),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveLayout.getHorizontalPadding(context),
          ),
          child: ResponsiveLayout(
            mobile: _buildMobileNav(context),
            desktop: _buildDesktopNav(context),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopNav(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(AppConstants.name, style: theme.textTheme.titleLarge),
        Row(
          children: [
            ...AppConstants.navItems.map((item) {
              final isActive = _activeSection == item['section'];
              return Padding(
                padding: const EdgeInsets.only(left: AppTheme.spacingL),
                child: _NavItem(
                  label: item['label']!,
                  isActive: isActive,
                  onTap: () => _scrollToSection(item['section']!),
                ),
              );
            }),
            const SizedBox(width: AppTheme.spacingS),
            ThemeToggleButton(themeProvider: widget.themeProvider),
          ],
        ),
      ],
    );
  }

  Widget _buildMobileNav(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppConstants.name.split(' ').first,
          style: theme.textTheme.titleMedium,
        ),
        Row(
          children: [
            ThemeToggleButton(themeProvider: widget.themeProvider),
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => _showMobileMenu(context),
            ),
          ],
        ),
      ],
    );
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppTheme.spacingM),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: AppConstants.navItems.map((item) {
              return ListTile(
                title: Text(item['label']!),
                onTap: () {
                  Navigator.pop(context);
                  _scrollToSection(item['section']!);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
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
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingS,
            vertical: AppTheme.spacingXS,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: widget.isActive || _isHovered
                    ? (isDark
                        ? AppTheme.darkAccent
                        : AppTheme.lightAccent)
                    : Colors.transparent,
                width: 2,
              ),
            ),
          ),
          child: Text(
            widget.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: widget.isActive || _isHovered
                  ? (isDark
                      ? AppTheme.darkAccent
                      : AppTheme.lightAccent)
                  : null,
              fontWeight:
                  widget.isActive ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
