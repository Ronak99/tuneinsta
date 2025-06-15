enum Routes {
  HOME_SCREEN,
  VIEW_IMAGE,
  DOCK_TEST,
}

extension RoutesExt on Routes {
  String get value {
    return '/${name.toLowerCase()}';
  }
}
