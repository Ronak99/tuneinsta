enum Routes {
  HOME_SCREEN,
  VIEW_IMAGE,
}

extension RoutesExt on Routes {
  String get value {
    return '/${name.toLowerCase()}';
  }
}
