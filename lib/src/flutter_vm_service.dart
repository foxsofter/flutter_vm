import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:vm_service/vm_service.dart';
import 'package:vm_service/vm_service_io.dart';
import 'dart:isolate' as iso;

class FlutterVmService {
  late final VmService vmService;
  var isOpen = false;

  Future<void> open() async {
    if (isOpen) {
      return;
    }
    isOpen = true;
    final serverUri = (await Service.getInfo()).serverUri;
    if (serverUri == null) {
      debugPrint('Please run the application with the --observe parameter!');
      return;
    }
    iso.Isolate.spawn((message) {}, 'message');
    vmService = await vmServiceConnectUri(_toWebSocket(serverUri));
  }

  void close() {
    vmService.dispose();
    isOpen = false;
  }

  Future<Map<String, dynamic>> getVM() async {
    await open();
    return vmService.getVM().then((it) => it.toJson());
  }

  Future<Map<String, dynamic>> getProcessMemoryUsage() async {
    await open();
    return vmService.getProcessMemoryUsage().then((it) => it.toJson());
  }

  Future<List<Map<String, dynamic>>> getIsolateGroup() async {
    await open();
    final vm = await vmService.getVM();
    final groups = <Map<String, dynamic>>[];
    for (final g in vm.isolateGroups!) {
      groups.add((await vmService.getIsolateGroup(g.id!)).toJson());
    }
    return groups;
  }

  Future<List<Map<String, dynamic>>> getIsolateGroupMemoryUsage() async {
    await open();
    final vm = await vmService.getVM();
    final groups = <Map<String, dynamic>>[];
    for (final g in vm.isolateGroups!) {
      groups.add((await vmService.getIsolateGroupMemoryUsage(g.id!)).toJson());
    }
    return groups;
  }

  Future<List<Map<String, dynamic>>> getSystemIsolateGroup() async {
    await open();
    final vm = await vmService.getVM();
    final groups = <Map<String, dynamic>>[];
    for (final g in vm.systemIsolateGroups!) {
      groups.add((await vmService.getIsolateGroup(g.id!)).toJson());
    }
    return groups;
  }

  Future<List<Map<String, dynamic>>> getSystemIsolateGroupMemoryUsage() async {
    await open();
    final vm = await vmService.getVM();
    final groups = <Map<String, dynamic>>[];
    for (final g in vm.systemIsolateGroups!) {
      groups.add((await vmService.getIsolateGroupMemoryUsage(g.id!)).toJson());
    }
    return groups;
  }

  Future<List<Map<String, dynamic>>> getIsolate() async {
    await open();
    final vm = await vmService.getVM();
    final groups = <Map<String, dynamic>>[];
    for (final it in vm.isolates!) {
      groups.add((await vmService.getIsolate(it.id!)).toJson());
    }
    return groups;
  }

  Future<List<Map<String, dynamic>>> getIsolateMemoryUsage() async {
    await open();
    final vm = await vmService.getVM();
    final groups = <Map<String, dynamic>>[];
    for (final it in vm.isolates!) {
      groups.add((await vmService.getMemoryUsage(it.id!)).toJson());
    }
    return groups;
  }

  Future<List<Map<String, dynamic>>> getSystemIsolate() async {
    await open();
    final vm = await vmService.getVM();
    final groups = <Map<String, dynamic>>[];
    for (final it in vm.systemIsolates!) {
      groups.add((await vmService.getIsolate(it.id!)).toJson());
    }
    return groups;
  }

  Future<List<Map<String, dynamic>>> getSystemIsolateMemoryUsage() async {
    await open();
    final vm = await vmService.getVM();
    final groups = <Map<String, dynamic>>[];
    for (final it in vm.systemIsolates!) {
      groups.add((await vmService.getMemoryUsage(it.id!)).toJson());
    }
    return groups;
  }

  Future<Map<String, dynamic>> getCurrentIsolateClassList() async {
    await open();
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
