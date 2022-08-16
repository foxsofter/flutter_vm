import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_vm_method_channel.dart';

abstract class FlutterVmPlatform extends PlatformInterface {
  /// Constructs a FlutterVmPlatform.
  FlutterVmPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterVmPlatform _instance = MethodChannelFlutterVm();

  /// The default instance of [FlutterVmPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterVm].
  static FlutterVmPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterVmPlatform] when
  /// they register themselves.
  static set instance(FlutterVmPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
