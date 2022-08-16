import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';
import 'dart:isolate' as iso;

class FlutterVmService {
  late final VmService vmService;

  Future<void> open() async {
    final serverUri = (await Service.getInfo()).serverUri;
    if (serverUri == null) {
      debugPrint('Please run the application with the --observe parameter!');
      return;
    }
    vmService = await vmServiceConnectUri(_toWebSocket(serverUri));
  }

  void close() {
    vmService.dispose();
  }

  Future<Map<String, dynamic>> getVM() {
    return vmService.getVM().then((it) => it.toJson());
  }

  Future<Map<String, dynamic>> getProcessMemoryUsage() {
    return vmService.getProcessMemoryUsage().then((it) => it.toJson());
  }

  Future<Map<String, dynamic>> getIsolateGroup() {
    final isolateId = Service.getIsolateID(iso.Isolate.current)!;
    return vmService.getIsolateGroup(isolateId).then((it) => it.toJson());
  }

  Future<Map<String, dynamic>> getIsolateGroupMemoryUsage() {
    final isolateId = Service.getIsolateID(iso.Isolate.current)!;
    return vmService.getIsolateGroupMemoryUsage(isolateId).then((it) => it.toJson());
  }

  Future<Map<String, dynamic>> getIsolate() {
    final isolateId = Service.getIsolateID(iso.Isolate.current)!;
    return vmService.getIsolate(isolateId).then((it) => it.toJson());
  }

  Future<Map<String, dynamic>> getIsolateMemoryUsage() {
    final isolateId = Service.getIsolateID(iso.Isolate.current)!;
    return vmService.getMemoryUsage(isolateId).then((it) => it.toJson());
  }

  Future<Map<String, dynamic>> getClassList() {
    final isolateId = Service.getIsolateID(iso.Isolate.current)!;
    return vmService.getClassList(isolateId).then((it) => it.toJson());
  }

  String _toWebSocket(Uri uri) {
    final pathSegments = _cleanupPathSegments(uri);
    pathSegments.add('ws');
    return uri.replace(scheme: 'ws', pathSegments: pathSegments).toString();
  }

  List<String> _cleanupPathSegments(Uri uri) {
    final pathSegments = <String>[];
    if (uri.pathSegments.isNotEmpty) {
      pathSegments.addAll(uri.pathSegments.where(
        (s) => s.isNotEmpty,
      ));
    }
    return pathSegments;
  }
}
