import 'dart:developer';

import 'package:testserverpod_client/testserverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:logging/logging.dart';
import 'package:testserverpod_flutter/features/home/presentation/pages/home_page.dart';

import 'core/di/injection_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initDependencyInjection();
  runApp(const MyApp());
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    log('${record.level.name}: ${record.loggerName}: ${record.message}');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Serverpod Demo',
      theme:
          ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomePage(title: 'Serverpod Example'),
    );
  }
}
