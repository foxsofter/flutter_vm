import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_vm/flutter_vm.dart';
import 'package:flutter_vm/flutter_vm_platform_interface.dart';
import 'package:flutter_vm/flutter_vm_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterVmPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterVmPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterVmPlatform initialPlatform = FlutterVmPlatform.instance;

  test('$MethodChannelFlutterVm is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterVm>());
  });

  test('getPlatformVersion', () async {
    FlutterVm flutterVmPlugin = FlutterVm();
    MockFlutterVmPlatform fakePlatform = MockFlutterVmPlatform();
    FlutterVmPlatform.instance = fakePlatform;
  
    expect(await flutterVmPlugin.getPlatformVersion(), '42');
  });
}
