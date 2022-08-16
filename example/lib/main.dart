import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_vm/flutter_vm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _flutterVmPlugin = FlutterVm();

  final vmservice = FlutterVmService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(24),
            child: Column(children: <Widget>[
              InkWell(
                onTap: () async {
                  await vmservice.open();
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    color: Colors.yellow,
                    child: const Text(
                      'connect dartvm',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ),
              InkWell(
                onTap: () async {
                  final map = await vmservice.getVM();
                  debugPrint("vm: ${jsonEncode(map)}");
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    color: Colors.grey,
                    child: const Text(
                      'get vm',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ),
              InkWell(
                onTap: () async {
                  final map = await vmservice.getProcessMemoryUsage();
                  debugPrint("process memory: ${jsonEncode(map)}");
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    color: Colors.grey,
                    child: const Text(
                      'get process memory',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ),
              InkWell(
                onTap: () async {
                  final map = await vmservice.getClassList();
                  debugPrint("classList: ${jsonEncode(map)}");
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    color: Colors.yellow,
                    child: const Text(
                      'get classList',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ),
              InkWell(
                onTap: () async {
                  final map = await vmservice.getIsolateGroup();
                  debugPrint("isolate group: ${jsonEncode(map)}");
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    color: Colors.yellow,
                    child: const Text(
                      'get isolate group',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ),
              InkWell(
                onTap: () async {
                  final map = await vmservice.getIsolateGroupMemoryUsage();
                  debugPrint("isolate group memory: ${jsonEncode(map)}");
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    color: Colors.yellow,
                    child: const Text(
                      'get isolate group memory',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ),
              InkWell(
                onTap: () async {
                  final map = await vmservice.getIsolate();
                  debugPrint("isolate: ${jsonEncode(map)}");
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    color: Colors.yellow,
                    child: const Text(
                      'get isolate',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ),
              InkWell(
                onTap: () async {
                  final map = await vmservice.getIsolateMemoryUsage();
                  debugPrint("isolate memory: ${jsonEncode(map)}");
                },
                child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.all(8),
                    color: Colors.grey,
                    child: const Text(
                      'get isolate memory',
                      style: TextStyle(fontSize: 22, color: Colors.black),
                    )),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
