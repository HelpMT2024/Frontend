import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:help_my_truck/data/models/engine.dart';
import 'package:help_my_truck/data/models/truck.dart';
import 'package:help_my_truck/services/API/graph_ql_network_service.dart';
import 'package:help_my_truck/services/API/profile_provider.dart';
import 'package:help_my_truck/services/API/rest_api_network_service.dart';
import 'package:help_my_truck/services/API/vehicle_provider.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen.dart';
import 'package:help_my_truck/ui/favorites_flow/favorites_screen_view_model.dart';
import 'package:help_my_truck/ui/profile_flow/profile_screen.dart';
import 'package:help_my_truck/ui/profile_flow/profile_screen_view_model.dart';
import 'package:help_my_truck/ui/widgets/app_gradient_bg_decorator.dart';
import 'package:help_my_truck/ui/widgets/custom_bottom_bar.dart';
import 'package:help_my_truck/ui/widgets/main_bottom_bar.dart';
import 'package:help_my_truck/ui/widgets/nav_bar/nav_bar_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/configuration_observer/configuration_observer_screen.dart';
import 'package:help_my_truck/ui/vehicle_observer_flow/configuration_observer/configuration_observer_view_model.dart';
import 'package:help_my_truck/ui/search_flow/search_screen.dart';

class MainPageConfig {
  final Engine engine;
  final Truck truck;
  final GraphQLNetworkService service;

  MainPageConfig({
    required this.engine,
    required this.truck,
    required this.service,
  });
}

class MainPageController extends ChangeNotifier {
  get selectedPage => _selectedPage;

  set selectedPage(value) {
    _selectedPage = value;
    notifyListeners();
  }

  NavBarPage _selectedPage = NavBarPage.home;

  MainPageController();
}

class MainPage extends StatefulWidget {
  final MainPageConfig config;

  const MainPage({super.key, required this.config});

  @override
  State<MainPage> createState() => _MainPageState();
}

final mainPageController = MainPageController();

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late final searchModalController = SearchModalController(
    provider: VehicleProvider(widget.config.service),
  );

  final controller = mainPageController;

  late final pageController = PageController(initialPage: 0);

  late final Map<NavBarPage, Widget> _widgetOptions = {
    NavBarPage.home: ConfigurationObserverScreen(
      viewModel: ConfigurationObserverViewModel(config: widget.config),
    ),
    NavBarPage.people: const SizedBox(),
    NavBarPage.search: const SizedBox(),
    NavBarPage.favorites: FavoritesScreen(
      viewModel: FavoritesScreenViewModel(
        provider: VehicleProvider(widget.config.service),
      ),
    ),
    NavBarPage.profile: ProfileScreen(
      viewModel: ProfileScreenViewModel(
        provider: ProfileProvider(),
      ),
    ),
  };

  void initPageState() {
    setState(() {
      controller._selectedPage = NavBarPage.home;
      pageController.jumpToPage(0);
    });

    controller.addListener(() {
      _onItemTapped(NavBarPage.values.indexOf(controller.selectedPage));
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

  void _onItemTapped(int index) {
    final pageStatus = NavBarPage.fromPage(index);

    if (pageStatus != NavBarPage.search) {
      setState(() {
        controller._selectedPage = pageStatus;
        pageController.jumpToPage(index);
      });
    } else {
      _showSearch();
    }
  }

  void _showSearch() async {
    final search = SearchScreen(searchModalController: searchModalController);

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return search;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      key: _scaffoldKey,
      //bottomNavigationBar: _buildNavBar(l10n),
      body: Container(
        decoration: appGradientBgDecoration,
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageController,
                allowImplicitScrolling: false,
                physics: const NeverScrollableScrollPhysics(),
                children: _widgetOptions.values.toList(),
              ),
            ),
            _buildNavBar(l10n),
            // Positioned(
            //   bottom: 0,
            //   left: 0,
            //   right: 0,
            //   child: _buildNavBar(l10n),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar(AppLocalizations? l10n) {
    return CustomBottomBar(
      selectedPage: controller._selectedPage,
      onItemTapped: _onItemTapped,
    );

    // return MainBottomBar(
    //   selectedPage: controller._selectedPage,
    //   onItemTapped: _onItemTapped,
    // );
  }
}
