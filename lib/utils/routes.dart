enum Routes {
  HOME_SCREEN,
  VIEW_IMAGE,
  DOCK_TEST,
  ADD_TRACK,
  SEARCH_TRACKS,
  VIEW_ALL_TRACKS,
}

extension RoutesExt on Routes {
  String get value {
    return '/${name.toLowerCase()}';
  }
}
