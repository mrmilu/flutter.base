import 'package:flutter/material.dart';

import '../router/app_router.dart';
import '../router/page_names.dart';
import '../utils/styles/colors.dart';
import 'button_scale_widget.dart';
import 'image_asset_widget.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColors.specificBasicWhite,
      leading: Center(
        child: ButtonScaleWidget(
          onTap: () => routerApp.pushNamed(
            PageNames.settingsProfileInfo,
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: ImageAssetWidget(
              path: 'assets/icons/top_bar_profile.svg',
              width: 24,
              height: 24,
            ),
          ),
        ),
      ),
      expandedHeight: 110,
      toolbarHeight: 44,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double paddingDynamic = _calculateDynamicPadding(
            constraints.maxHeight,
          );
          return FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.only(
              left: paddingDynamic,
              right: paddingDynamic,
            ),
            expandedTitleScale: 1.4,
            title: const Text('data'),
          );
        },
      ),
      actions: [
        // ButtonScaleWidget(
        //   onTap: () {},
        //   child: const Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: ImageAssetWidget(
        //       path: 'assets/icons/phone.svg',
        //       width: 24,
        //       height: 24,
        //     ),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.only(right: 8.0),
        //   child: ButtonScaleWidget(
        //     onTap: () => routerApp.pushNamed(PageNames.checkout),
        //     child: const Padding(
        //       padding: EdgeInsets.all(8.0),
        //       child: ImageAssetWidget(
        //         path: 'assets/icons/top_bar_bell.svg',
        //         width: 24,
        //         height: 24,
        //       ),
        //     ),
        //   ),
        // ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.black12,
          height: 1.0,
        ),
      ),
    );
  }
}

double _calculateDynamicPadding(double height) {
  const double maxHeight = 110;
  const double minHeight = 65;
  const double maxPadding = 16;
  const double minPadding = 92;

  if (height >= maxHeight) return maxPadding;
  if (height <= minHeight) return minPadding;

  double factor = (height - minHeight) / (maxHeight - minHeight);
  return minPadding + (maxPadding - minPadding) * factor;
}
