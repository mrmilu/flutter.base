import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/navigation/app_navigation_item.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/navigation/app_navigation_item_widget.dart';

class AppNavigationRail extends StatelessWidget {
  final List<AppNavigationItem> items;
  final int selectedIndex;
  final Function(int idx)? onItemTapped;

  const AppNavigationRail({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: FlutterBaseColors.specificSurfaceLow,
      ),
      child: Padding(
        padding: Insets.a12,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          children: items.asMap().entries.map(
            (entry) {
              final item = entry.value;
              final idx = entry.key;
              return AppNavigationItemWidget(
                key: Key('bottom-bar-item-$idx'),
                selected: idx == selectedIndex,
                item: item,
                onTap: () => onItemTapped?.call(idx),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
