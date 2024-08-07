import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/border_radius.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/box_shadows.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/navigation/app_navigation_item.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/navigation/app_navigation_item_widget.dart';

class AppNavigationBottomBar extends StatelessWidget {
  final List<AppNavigationItem> items;
  final int selectedIndex;
  final Function(int idx)? onItemTapped;

  const AppNavigationBottomBar({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: CircularBorderRadius.br16,
        color: FlutterBaseColors.specificSurfaceLow,
        boxShadow: BoxShadows.bs1,
      ),
      child: Padding(
        padding: Insets.a4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
