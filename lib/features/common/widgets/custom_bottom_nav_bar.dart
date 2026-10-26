import 'package:flutter/material.dart';

/// الموديل الخاص بكل زر في الـ Bottom Navigation Bar
class CustomBottomNavItem {
  final String? selectedAsset;
  final String? unselectedAsset;
  final IconData? selectedIcon;
  final IconData? unselectedIcon;
  final String? label;

  const CustomBottomNavItem({
    this.selectedAsset,
    this.unselectedAsset,
    this.selectedIcon,
    this.unselectedIcon,
    this.label,
  });
}

/// ودجت عام قابل لإعادة الاستخدام في أي مشروع Flutter
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<CustomBottomNavItem> items;
  final Color backgroundColor;
  final Color selectedCircleColor;
  final Color selectedColor;
  final Color unselectedColor;
  final BorderRadius? borderRadius;
  final double circleRadius;
  final double iconSize;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.items,
    this.backgroundColor = const Color(0xFF004182),
    this.selectedCircleColor = Colors.white,
    this.selectedColor = const Color(0xFF004182),
    this.unselectedColor = Colors.white,
    this.borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(18),
      topRight: Radius.circular(18),
    ),
    this.circleRadius = 24.0,
    this.iconSize = 22.0,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BottomAppBar(
        color: backgroundColor,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(items.length, (index) {
            final isSelected = currentIndex == index;
            final item = items[index];

            return InkWell(
              onTap: () => onTap(index),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: const EdgeInsets.all(4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: circleRadius,
                      backgroundColor: isSelected
                          ? selectedCircleColor
                          : Colors.transparent,
                      child: _buildIcon(item, isSelected),
                    ),
                    if (item.label != null && item.label!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        item.label!,
                        style: TextStyle(
                          fontSize: 12,
                          color: isSelected ? selectedCircleColor : unselectedColor,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildIcon(CustomBottomNavItem item, bool isSelected) {
    // 1. لو تم تمرير Asset Images
    if (item.selectedAsset != null || item.unselectedAsset != null) {
      final assetPath = isSelected
          ? (item.selectedAsset ?? item.unselectedAsset!)
          : (item.unselectedAsset ?? item.selectedAsset!);
      return Image.asset(
        assetPath,
        width: iconSize,
        height: iconSize,
        fit: BoxFit.contain,
      );
    }

    // 2. لو تم تمرير IconData العادي
    final iconData = isSelected
        ? (item.selectedIcon ?? item.unselectedIcon!)
        : (item.unselectedIcon ?? item.selectedIcon!);

    return Icon(
      iconData,
      size: iconSize,
      color: isSelected ? selectedColor : unselectedColor,
    );
  }
}
