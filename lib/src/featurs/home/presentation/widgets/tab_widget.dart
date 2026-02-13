
import '../../../../src_export.dart';

class TabWidget extends StatefulWidget {
  final String title;
  final String img;
  const TabWidget({super.key, required this.title, required this.img});

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  late HomeBloc _homeBloc;
  @override
  void initState() {
    // TODO: implement initState
      _homeBloc = HomeBloc();
    super.initState();
  }
  @override
  void dispose() {
_homeBloc.close();
super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<HomeBloc, HomeState>(
        bloc: _homeBloc,
        builder: (context, state) {
          bool isMapView = false;
          if (state is ToggleViewState) {
            isMapView = state.isMapView;
          }
      return Container(
        padding: AppPadding.getPadding12(context),
        decoration: BoxDecoration(
          color: isMapView? AppColors.kPrimaryColor:Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ButtonTapWidget(
          onTap: () {
            _homeBloc.add(ToggleThemeEvent(isMapView: !isMapView));
          },
          child: Row(

              children: [SvgPicture.asset(widget.img,colorFilter: ColorFilter.mode(isMapView? Colors.white:AppColors.kSecondaryTextColor,
              BlendMode.srcIn),), Expanded(child: CustomText(widget.title,color: isMapView? Colors.white:AppColors.kSecondaryTextColor,))]),
        ),
      );
        },
      ),
    );
  }
}
