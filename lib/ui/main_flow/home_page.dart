import 'dart:io';
import 'package:help_my_truck/const/colors.dart';
import 'package:help_my_truck/const/resource.dart';
import 'package:help_my_truck/data/models/engine.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/ui/lib/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/lib/nav_bar/custom_navigation_bar_icon.dart';
import 'package:help_my_truck/ui/lib/nav_bar/main_navigation_bar.dart';
import 'package:help_my_truck/ui/lib/nav_bar/nav_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/search_flow/search_modal_builder.dart';
import 'package:help_my_truck/ui/search_flow/search_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainPageConfig {
  final Engine engine;
  final Truck truck;

  MainPageConfig({required this.engine, required this.truck});
}

class MainPage extends StatefulWidget {
  final MainPageConfig config;

  const MainPage({super.key, required this.config});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  NavBarPage _selectedPage = NavBarPage.home;
  final SearchModalController searchModalController = SearchModalController();

  late final pageController = PageController(
    initialPage: 0,
  );

  late final Map<NavBarPage, Widget> _widgetOptions = {
    NavBarPage.home: const SizedBox(),
    NavBarPage.people: const SizedBox(),
    NavBarPage.search: const SizedBox(),
    NavBarPage.favorites: const SizedBox(),
    NavBarPage.profile: const SizedBox()
  };

  void initPageState() {
    setState(() {
      _selectedPage = NavBarPage.home;
      pageController.jumpToPage(0);
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initPageState();
    });
    WidgetsBinding.instance.addObserver(this);
  }

  void _onItemTapped(int index, AppLocalizations? l10n) {
    final pageStatus = NavBarPage.fromPage(index);

    if (pageStatus != NavBarPage.search) {
      setState(() {
        _selectedPage = pageStatus;
        pageController.jumpToPage(index);
      });
    } else {
      _showSearch();
    }
  }

  _showSearch() async {
    setState(() {
      final double offset = searchModalController.offset == 0 ? 0.5 : 0;
      searchModalController.processOffset(offset);
      searchModalController.panelController.animatePanelToPosition(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final styles = Theme.of(context).textTheme;

    return Scaffold(
      key: _scaffoldKey,
      extendBody: true,
      appBar: MainNavigationBar(
        context: context,
        styles: styles,
      ),
      bottomNavigationBar: _buildNavBar(l10n),
      body: SearchModalBuilder(
        searchModalController: searchModalController,
        builder: (context) =>
        Container(
          decoration: appGradientBgDecoration,
          child: PageView(
            controller: pageController,
            allowImplicitScrolling: false,
            physics: const NeverScrollableScrollPhysics(),
            children: _widgetOptions.values.toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavBar(AppLocalizations? l10n) {
    return SafeArea(
      child: PlatformNavBar(
        backgroundColor: ColorConstants.surfacePrimaryDark,
        material: (_, __) => MaterialNavBarData(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          padding: EdgeInsets.zero,
        ),
        material3: (context, platform) {
          return MaterialNavigationBarData(
            height: 68,
            elevation: 0,
            backgroundColor: ColorConstants.surfacePrimaryDark,
            indicatorColor: ColorConstants.surfacePrimaryDark,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          );
        },
        cupertino: (context, platform) => CupertinoTabBarData(height: 51),
        items: [
          _customIcon(
            asset: R.ASSETS_HOME_SVG,
            navBarPage: NavBarPage.home,
            text: 'Home',
          ),
          _customIcon(
            asset: R.ASSETS_PEOPLE_SVG,
            navBarPage: NavBarPage.people,
            text: 'People',
          ),
          _customIcon(
              icon: Icons.search_rounded,
              navBarPage: NavBarPage.search,
              isCenterIcon: true,
              text: 'Fault Code'),
          _customIcon(
            asset: R.ASSETS_FAVORITE_STAR_SVG,
            navBarPage: NavBarPage.favorites,
            text: 'Favorites',
          ),
          _customIcon(
            asset: R.ASSETS_PROFILE_IMAGE_SVG,
            navBarPage: NavBarPage.profile,
            text: 'Profile',
          )
        ],
        currentIndex: _selectedPage.indexPage,
        itemChanged: (int index) => _onItemTapped(index, l10n),
      ),
    );
  }

  BottomNavigationBarItem _customIcon({
    String? asset,
    IconData? icon,
    bool isCenterIcon = false,
    NavBarPage navBarPage = NavBarPage.home,
    String? text,
    double size = 24,
    double padding = 0,
  }) {
    bool isActive = navBarPage == _selectedPage;
    return BottomNavigationBarItem(
      icon: Container(
        padding: EdgeInsets.only(top: Platform.isAndroid ? 0 : 5),
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          child: CustomNavigationBarIcon(
            asset: asset,
            icon: icon,
            isCenterItem: isCenterIcon,
            isActiveItem: isActive,
            text: text,
            size: size,
            padding: padding,
          ),
        ),
      ),
    );
  }
}
