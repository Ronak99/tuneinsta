enum AppName {
  instagramStories,
  instagram,
}


final Map<String, AppName> appNameMap = {
  "instagram_stories": AppName.instagramStories,
  "instagram": AppName.instagram,
};

class AppShare {
  AppName appName;

  AppShare({required this.appName});

  factory AppShare.fromAppName(String appNameValue) {
    final appName = appNameMap[appNameValue];
    if (appName == null) {
      throw ArgumentError('Invalid app name: $appNameValue');
    }
    return AppShare(appName: appName);
  }

  String get label => switch(appName){
    AppName.instagramStories => "Story",
    AppName.instagram => "Post",
  };

  String get icon => switch(appName) {
    AppName.instagramStories => "assets/instagram.png",
    AppName.instagram => "assets/instagram.png",
  };
}
