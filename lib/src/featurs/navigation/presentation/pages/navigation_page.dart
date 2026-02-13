import '../../../../src_export.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
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

            currentIndex: currentIndex,
            onTap: (index) {
              _navigationBloc.add(ChangeNavEvent(currentIndex: index));
            },
            items: [
              _buildBottomNavItem(
                  ImagesConstant.kHomeIcon, AppStaticStrings.home, currentIndex, 0),
              _buildBottomNavItem(
                  ImagesConstant.kOrderIcon, AppStaticStrings.orders, currentIndex, 1),

                _buildBottomNavItem(
                    ImagesConstant.kCartIcon, AppStaticStrings.cart, currentIndex, 2),
                  _buildBottomNavItem(
                  ImagesConstant.kProfileIcon, AppStaticStrings.profile, currentIndex,3),
            ],
            backgroundColor:Colors.white,
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(
      String icon, String label, int currentIndex, int index) {
    return BottomNavigationBarItem(

      icon: SvgPicture.asset(
        icon,
        height: 20
        // color: currentIndex == index
        //     ? AppColors.kPrimaryColor
        //     : AppColors.kSubTextColor,
      ),

      label: label,
    );
  }
}
