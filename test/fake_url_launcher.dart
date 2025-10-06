import 'package:url_launcher_platform_interface/link.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

class FakeUrlLauncher extends UrlLauncherPlatform {
  bool canLaunchResult = true;
  bool shouldThrow = false;
  final launchedUrls = <String>[];

  @override
  Future<bool> canLaunch(String url) async {
    if (shouldThrow) throw Exception('Fake launch error');
    return canLaunchResult;
  }

  @override
  Future<bool> launchUrl(String url, LaunchOptions options) async {
    if (shouldThrow) throw Exception('Fake launch error');
    launchedUrls.add(url);
    return true;
  }

  @override
  LinkDelegate? get linkDelegate => throw UnimplementedError();
}
