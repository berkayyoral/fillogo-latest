import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {
  static final Permissions _instance = Permissions._init();
  static Permissions get instance => _instance;
  Permissions._init();

  void requestPermission(BuildContext context, Permission permission) async {
    var status = await permission.status;

    requestPermissionWithOpenSettings();
  }

  void requestPermissionWithOpenSettings() async {
    openAppSettings();
  }
}
