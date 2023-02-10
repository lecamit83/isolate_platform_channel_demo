import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:isolate_background/plugins/versions/version_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _versionName = "";
  String _versionBuild = "";

  Isolate? _channelIsolate;

  @override
  void initState() {
    super.initState();
    RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
    ReceivePort rootIsolatePort = ReceivePort();
    Isolate.spawn(_isolateMain, [rootIsolateToken, rootIsolatePort.sendPort])
        .then((value) => _channelIsolate = value);
    rootIsolatePort.listen((message) {
      setState(() {
        _versionName = message["versionName"];
        _versionBuild = message["versionBuild"];
      });
    });
  }

  static void _isolateMain(List<dynamic> args) async {
    RootIsolateToken rootIsolateToken = args[0];
    SendPort port = args[1];
    // Register the background isolate with the root isolate.
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    // You can now use the shared_preferences plugin.
    String versionBuild = await VersionManager().getAppVersionBuild();
    String versionName = await VersionManager().getAppVersionName();
    print("Log: $versionName($versionBuild)");
    port.send({
      "versionBuild": versionBuild,
      "versionName": versionName,
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_versionName($_versionBuild)',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
