import '../../../../src_export.dart';

class ShopNavigationPage extends StatefulWidget {
  const ShopNavigationPage({super.key});

  @override
  State<ShopNavigationPage> createState() => _ShopNavigationPageState();
}

class _ShopNavigationPageState extends State<ShopNavigationPage> {
  late NavigationBloc _navigationBloc;

  @override
  void initState() {
    super.initState();
    _navigationBloc = NavigationBloc();
  }

  @override
  void dispose() {
    _navigationBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      ShopHomePage(),
      ShopOrderManagementPage(),
      ShopMenuManagementPage(),
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => sl<PromotionBloc>()..add(GetPromotionsEvent())),
          BlocProvider(create: (context) => sl<MenuBloc>()..add(GetMenuItemsEvent())),
        ],
        child: const PromotionPage(),
      ),
      BusinessProfilePage(),
    ];

    return BlocBuilder<NavigationBloc, NavigationState>(
      bloc: _navigationBloc,
      builder: (context, state) {
        int currentIndex = 0;
        if (state is NavigationChangeState) {
          currentIndex = state.currentIndex;
        }

        return Scaffold(
          body: SafeArea(
            child: IndexedStack(index: currentIndex, children: pages),
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedItemColor: AppColors.kPrimaryColor,
            unselectedItemColor: AppColors.kSecondaryTextColor,
            currentIndex: currentIndex,
            onTap: (index) {
              _navigationBloc.add(ChangeNavEvent(currentIndex: index));
            },
            items: [
              _buildBottomNavItem(
                ImagesConstant.kHomeIcon,
                AppStaticStrings.home,
                currentIndex,
                0,
              ),
              _buildBottomNavItem(
                ImagesConstant.kOrderIcon,
                AppStaticStrings.orders,
                currentIndex,
                1,
              ),
              _buildBottomNavItem(
                ImagesConstant.kMenuIcon,
                AppStaticStrings.menu,
                currentIndex,
                2,
              ),
              _buildBottomNavItem(
                ImagesConstant.kGiftIcon,
                AppStaticStrings.promotions,
                currentIndex,
                3,
              ),
              _buildBottomNavItem(
                ImagesConstant.kProfileIcon,
                AppStaticStrings.profile,
                currentIndex,
                4,
              ),
            ],
            backgroundColor: Colors.white,
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
    String icon,
    String label,
    int currentIndex,
    int index,
  ) {
    return BottomNavigationBarItem(
      tooltip: label,
      icon: SvgPicture.asset(
        icon,
        height: 20,
        colorFilter: ColorFilter.mode(
          currentIndex == index
              ? AppColors.kPrimaryColor
              : AppColors.kSecondaryTextColor,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
