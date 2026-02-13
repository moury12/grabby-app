import 'package:flutter/cupertino.dart';

import '../../../../src_export.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.getPadding12(context),
              child: CustomTextField(
                prefixIcon: Icon(
                  CupertinoIcons.search,
                  color: AppColors.kSecondaryTextColor.withValues(alpha: .5),
                ),
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: AppColors.kSecondaryTextColor,
                ),
                hintText: AppStaticStrings.searchCafes,
                borderColor: AppColors.kSecondaryTextColor.withValues(
                  alpha: .5,
                ),
                borderRadius: 22,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppPadding.getPadding12(context),
              child: Row(
                children: [
                  TabWidget(
                    img: ImagesConstant.kListIcon,
                    title: AppStaticStrings.listView,
                  ),
                  TabWidget(
                    title: AppStaticStrings.mapView,
                    img: ImagesConstant.kMapIcon,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

