enum ChildType {
  standart,
  warningLight,
  search;
}

ChildType childTypeFromJson(String str) {
  switch (str) {
    case 'WarningLight':
      return ChildType.warningLight;
    case 'Search':
      return ChildType.search;
    default:
      return ChildType.standart;
  }
}
