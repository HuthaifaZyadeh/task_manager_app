// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:simple_do/src/base_app.dart';
import 'package:simple_do/src/di/app_initializer.dart';

import 'flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.dev;
  await AppInitializer.init();
  runApp(const BaseApp());
}
