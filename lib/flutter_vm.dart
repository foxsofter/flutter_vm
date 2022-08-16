library flutter_vm;

export 'src/flutter_vm_service.dart';

import 'flutter_vm_platform_interface.dart';

class FlutterVm {
  Future<String?> getPlatformVersion() {
    return FlutterVmPlatform.instance.getPlatformVersion();
  }
}
