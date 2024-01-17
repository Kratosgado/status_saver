import 'dart:io';

import 'package:flutter/material.dart';
import 'package:status_saver/src/settings/settings_controller.dart';
import 'package:status_saver/src/views/settings/settings_view.dart';
import 'package:status_saver/src/status/view_status.item.dart';
import 'package:status_saver/src/views/media_folder/media_folder.dart';

class RouteManager {
  static const String viewProfile = 'viewProfile';
  static const String mediafolder = 'mediafolder';
  static const String setting = 'settings';

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      fullscreenDialog: true,
      builder: (context) {
        switch (settings.name) {
          case viewProfile:
            return OpenStatusView(
              file: settings.arguments as File,
            );
          case mediafolder:
            return const MediaFolderView();
          case setting:
            return SettingsView(
              controller: settings.arguments as SettingsController,
            );
          default:
            return const MediaFolderView();
        }
      },
    );
  }
}
