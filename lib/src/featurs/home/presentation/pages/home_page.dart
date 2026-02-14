import 'package:flutter/cupertino.dart';

import '../../../../src_export.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      PromotedShopsSheet.show(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          bool isMapView = false;
          if (state is HomeInitial) {
            isMapView = state.isMapView;
          } else if (state is ToggleViewState) {
            isMapView = state.isMapView;
          }
          return CustomScrollView(
            physics: isMapView
                ? const NeverScrollableScrollPhysics()
                : const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppPadding.getPadding12(context),
                  child: CustomTextField(
                    prefixIcon: Icon(
                      CupertinoIcons.search,
                      color: AppColors.kSecondaryTextColor.withValues(
                        alpha: .5,
                      ),
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
                  padding: AppPadding.getPadding12(context).copyWith(top: 0),
                  child: Row(
                    spacing: 8,
                    children: [
                      TabWidget(
                        img: ImagesConstant.kListIcon,
                        title: AppStaticStrings.listView,
                        isSelected: !isMapView,
                        onTap: () {
                          context.read<HomeBloc>().add(
                            ToggleThemeEvent(isMapView: false),
                          );
                        },
                      ),
                      TabWidget(
                        title: AppStaticStrings.mapView,
                        img: ImagesConstant.kMapIcon,
                        isSelected: isMapView,
                        onTap: () {
                          context.read<HomeBloc>().add(
                            ToggleThemeEvent(isMapView: true),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              isMapView ? const HomeMapView() : const HomeListView(),
            ],
          );
        },
      ),
    );
  }
}
