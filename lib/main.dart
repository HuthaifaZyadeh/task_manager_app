import 'package:flutter/cupertino.dart';
import 'package:simple_do/src/base_app.dart';
import 'package:simple_do/src/di/app_initializer.dart';

import 'flavors.dart';

Future<void> main() async {
  F.appFlavor = Flavor.production;
  await AppInitializer.init();
  runApp(const BaseApp());
}
