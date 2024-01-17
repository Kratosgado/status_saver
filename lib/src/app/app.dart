import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as pt;
import 'package:status_saver/src/resources/route.manager.dart';
import 'package:status_saver/src/resources/theme.manager.dart';

import '../settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          theme: getApplicationTheme(),
          // darkTheme: ThemeData.dark(),

          themeMode: settingsController.themeMode,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteManager.onGenerateRoute,
        );
      },
    );
  }
}
