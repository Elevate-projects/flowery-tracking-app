import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/foundation.dart'; 

class FakeAssetBundle extends Fake implements AssetBundle {
  final Map<String, String> _assets;

  FakeAssetBundle(this._assets);

  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    if (_assets.containsKey(key)) {
      return _assets[key]!;
    }
    throw FlutterError('Asset not found: $key');
  }
}