import 'dart:io';
import 'dart:ui';

import 'package:app/models/share/AppShare.dart';
import 'package:appinio_social_share/appinio_social_share.dart';

class ShareService {
  final _appInioSocialShare = AppinioSocialShare();
  Map<String, bool> _installedApps = {};

  List<AppShare> _apps = [];

  List<AppShare> get apps => _apps;

  ShareService() {
    init();
  }

  init() async {
    _installedApps = await _appInioSocialShare.getInstalledApps();
    _apps = _installedApps.entries
        .where((app) => appNameMap.keys.contains(app.key) && app.value)
        .map((e) => AppShare.fromAppName(e.key))
        .toList();
  }

  void _share({required VoidCallback onAndroid, required VoidCallback onIOS}) {
    if (Platform.isAndroid) {
      onAndroid();
    } else {
      onIOS();
    }
  }

  Future<void> share(AppShare appShare, {required String filePath}) async {
    switch (appShare.appName) {
      case AppName.whatsapp:
        _share(
          onAndroid: () => _appInioSocialShare.android.shareToWhatsapp(
            "",
            "",
          ),
          onIOS: () => _appInioSocialShare.iOS.shareToWhatsapp(""),
        );
      case AppName.instagramStories:
        _share(
          onAndroid: () => _appInioSocialShare.android.shareToInstagramStory(
            "appId",
            backgroundImage: filePath,
          ),
          onIOS: () => _appInioSocialShare.iOS.shareToInstagramStory(
            "appId",
            backgroundImage: filePath,
          ),
        );
      case AppName.instagram:
        _share(
          onAndroid: () =>
              _appInioSocialShare.android.shareToInstagramFeed("", filePath),
          onIOS: () => _appInioSocialShare.iOS.shareToInstagramFeed(filePath),
        );
      case AppName.facebookStories:
        _share(
          onAndroid: () => _appInioSocialShare.android
              .shareToFacebookStory("", backgroundImage: filePath),
          onIOS: () => _appInioSocialShare.iOS
              .shareToFacebookStory("", backgroundImage: filePath),
        );
      default:
        print("Nothing");
    }
  }
}
