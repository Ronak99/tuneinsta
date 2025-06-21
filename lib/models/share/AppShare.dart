
enum AppName {
  whatsapp,
  instagramStories,
  instagram,
  facebookStories;
}

class AppShare {
  AppName appName;

  AppShare({required this.appName});

  static final Map<String, AppName> _appNameToEnumMap = {
    "instagram_stories": AppName.instagramStories,
    "instagram": AppName.instagram,
    "whatsapp": AppName.whatsapp,
    "facebook_stories": AppName.facebookStories,
  };

  factory AppShare.fromAppName(String appNameValue) {
    final appName = _appNameToEnumMap[appNameValue];
    if (appName == null) {
      throw ArgumentError('Invalid app name: $appNameValue');
    }
    return AppShare(appName: appName);
  }

  String get label => switch(appName){
    AppName.whatsapp => "Story",
    AppName.instagramStories => "Story",
    AppName.instagram => "Post",
    AppName.facebookStories => "FB Story",
  };

  String get icon => switch(appName) {
    AppName.whatsapp => "assets/whatsapp.png",
    AppName.instagramStories => "assets/instagram.png",
    AppName.instagram => "assets/instagram.png",
    AppName.facebookStories => "assets/facebook.png",
  };
}
