import 'dart:io';

import 'package:video_player/video_player.dart';

import '../../export.dart';

class VideoWidgetController extends GetxController {
  late Rx<VideoPlayerController> _videoPlayerController;

  final RxDouble _sliderPosition = (0.0).obs;
  double get sliderPosition => _sliderPosition.value;
  set sliderPosition(double value) => _sliderPosition.value = value;

  final RxBool _isPlaying = false.obs;
  bool get isPlaying => _isPlaying.value;
  set isPlaying(value) => _isPlaying.value = value;

  final RxBool _isInitialized = false.obs;
  bool get isInitialized => _isInitialized.value;
  set isInitialized(value) => _isInitialized.value = value;

  VideoPlayerController get videoPlayerController =>
      _videoPlayerController.value;
  set videoPlayerController(value) => _videoPlayerController.value = value;

  void initVideo(File file) async {
    _videoPlayerController = VideoPlayerController.file(file).obs;
    _videoPlayerController.value.initialize().then(
      (_) {
        isInitialized = _videoPlayerController.value.value.isInitialized;
        _videoPlayerController.value.addListener(() {
          isPlaying = videoPlayerController.value.isPlaying;
          sliderPosition =
              videoPlayerController.value.position.inSeconds.toDouble();
        });
        _videoPlayerController.value.play();
        update();
      },
    );
  }
}
