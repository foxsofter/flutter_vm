import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_vm_platform_interface.dart';

/// An implementation of [FlutterVmPlatform] that uses method channels.
class MethodChannelFlutterVm extends FlutterVmPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_vm');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
