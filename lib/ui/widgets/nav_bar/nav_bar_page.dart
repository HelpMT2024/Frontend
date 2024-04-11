enum NavBarPage {
  home,
  people,
  search,
  favorites,
  profile;

  static NavBarPage fromPage(int page) {
    switch (page) {
      case 0:
        return NavBarPage.home;
      case 1:
        return NavBarPage.people;
      case 2:
        return NavBarPage.search;
      case 3:
        return NavBarPage.favorites;
      case 4:
        return NavBarPage.profile;
    }
    return NavBarPage.home;
  }
}

extension NavBarPageX on NavBarPage {
  int get indexPage =>
      const {
        NavBarPage.home: 0,
        NavBarPage.people: 1,
        NavBarPage.search: 2,
        NavBarPage.favorites: 3,
        NavBarPage.profile: 4,
      }[this] ??
      0;
}
