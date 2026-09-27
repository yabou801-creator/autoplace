import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import './custom_icon_widget.dart';

class _TabSpec {
  final String label;
  final String icon;
  final String selectedIcon;
  final int? branchIndex;

  const _TabSpec({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.branchIndex,
  });
}

class AppNavigation extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppNavigation({required this.navigationShell, super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  // TODO: Replace with [Riverpod/Bloc] for production
  int _selectedVisualIndex = 0;

  static const List<_TabSpec> _tabs = [
    _TabSpec(
      label: 'Accueil',
      icon: 'home_outlined',
      selectedIcon: 'home',
      branchIndex: 0,
    ),
    _TabSpec(
      label: 'Recherche',
      icon: 'search',
      selectedIcon: 'search',
      branchIndex: null,
    ),
    _TabSpec(label: '', icon: 'add', selectedIcon: 'add', branchIndex: 1),
    _TabSpec(
      label: 'Favoris',
      icon: 'favorite_border',
      selectedIcon: 'favorite',
      branchIndex: null,
    ),
    _TabSpec(
      label: 'Plus',
      icon: 'menu',
      selectedIcon: 'menu',
      branchIndex: null,
    ),
  ];

  void _onTabTap(int visualIndex) {
    final tab = _tabs[visualIndex];
    if (tab.branchIndex == null) return; // stub tab — silent ignore

    setState(() {
      _selectedVisualIndex = visualIndex;
    });
    widget.navigationShell.goBranch(
      tab.branchIndex!,
      initialLocation: tab.branchIndex == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Sync visual index with actual shell index
    final currentBranch = widget.navigationShell.currentIndex;
    for (int i = 0; i < _tabs.length; i++) {
      if (_tabs[i].branchIndex == currentBranch) {
        if (_selectedVisualIndex != i) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) setState(() => _selectedVisualIndex = i);
          });
        }
        break;
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          color: AppTheme.navy,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: AppTheme.navy.withAlpha(89),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: List.generate(_tabs.length, (index) {
            final tab = _tabs[index];
            final isActive = index == _selectedVisualIndex;
            final isStub = tab.branchIndex == null && index != 2;
            final isCenter = index == 2;

            if (isCenter) {
              return Expanded(
                child: GestureDetector(
                  onTap: () => _onTabTap(index),
                  child: Center(
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.primary,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.primary.withAlpha(102),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              );
            }

            return Expanded(
              child: GestureDetector(
                onTap: () => _onTabTap(index),
                behavior: HitTestBehavior.opaque,
                child: Opacity(
                  opacity: isStub ? 0.4 : 1.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppTheme.primary.withAlpha(51)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: isActive ? tab.selectedIcon : tab.icon,
                          color: isActive
                              ? AppTheme.primary
                              : Colors.white.withAlpha(179),
                          size: 22,
                        ),
                        if (tab.label.isNotEmpty) ...[
                          const SizedBox(height: 2),
                          AnimatedDefaultTextStyle(
                            duration: const Duration(milliseconds: 200),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: isActive
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              color: isActive
                                  ? AppTheme.primary
                                  : Colors.white.withAlpha(179),
                            ),
                            child: Text(tab.label),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
