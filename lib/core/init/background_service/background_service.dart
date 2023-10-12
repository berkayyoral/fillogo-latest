import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';

class BackgroundService {
  final Function(ServiceInstance) androidOnStart;
  final Function(ServiceInstance)? iosOnForeground;
  final FutureOr<bool> Function(ServiceInstance)? iosOnBackground;

  BackgroundService({
    required this.androidOnStart,
    this.iosOnForeground,
    this.iosOnBackground,
  });

  Future<void> initService() async {
    final service = FlutterBackgroundService();
    service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: iosOnForeground,
        onBackground: iosOnBackground,
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: androidOnStart,
        isForegroundMode: true,
        autoStart: true,
      ),
    );
  }
}

// Example Usage

// BackgroundService backgroundService = BackgroundService(
// androidOnStart: onStart,
// );

//   void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await backgroundService.initService();
//   runApp(MyApp());
// }

// Future<void> onStart(ServiceInstance service) async {
//   DartPluginRegistrant.ensureInitialized();
//   var count = 1;
//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 10), (timer) async {
//     log(count.toString());
//     count++;
//   });
// }