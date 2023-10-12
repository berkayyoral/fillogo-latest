import 'dart:io';

import 'package:fillogo/controllers/media/video_widget_controller.dart';
// ignore: depend_on_referenced_packages
import 'package:video_player/video_player.dart';

import '../../export.dart';

// ignore: must_be_immutable
class VideoPlayerWidget extends StatelessWidget {
  VideoPlayerWidget({Key? key, required this.file}) : super(key: key);

  final File file;

  VideoWidgetController videoWidgetController =
      Get.put(VideoWidgetController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VideoWidgetController>(
      init: VideoWidgetController(),
      initState: (_) {
        videoWidgetController.initVideo(file);
      },
      builder: (_) {
        return Obx(
          () {
            return videoWidgetController.isInitialized
                ? Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: videoWidgetController.isPlaying
                              ? () {
                                  videoWidgetController.videoPlayerController
                                      .pause();
                                }
                              : () {
                                  videoWidgetController.videoPlayerController
                                      .play();
                                },
                          child: AspectRatio(
                            aspectRatio: videoWidgetController
                                .videoPlayerController.value.aspectRatio,
                            child: VideoPlayer(
                                videoWidgetController.videoPlayerController),
                          ),
                        ),
                      ),
                      videoWidgetController.isPlaying
                          ? const SizedBox()
                          : Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_arrow_rounded,
                                size: 40.r,
                                color: Colors.white,
                                shadows: [
                                  BoxShadow(
                                    offset: const Offset(4, 4),
                                    blurRadius: 20,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: 20.h,
                          width: Get.width,
                          child: SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                                trackHeight: 4,
                                thumbShape: const RoundSliderThumbShape(
                                  enabledThumbRadius: 6,
                                  pressedElevation: 6,
                                ),
                                overlayShape: const RoundSliderOverlayShape(
                                  overlayRadius: 1,
                                ),
                                trackShape: const RectangularSliderTrackShape(),
                                activeTrackColor: Colors.red,
                                inactiveTrackColor: Colors.black,
                                thumbColor: Colors.grey,
                                overlayColor: Colors.white),
                            child: Obx(() {
                              return Slider(
                                min: 0.0,
                                max: videoWidgetController.videoPlayerController
                                    .value.duration.inSeconds
                                    .toDouble(),
                                value: videoWidgetController.sliderPosition,
                                onChanged: (value) {
                                  videoWidgetController.videoPlayerController
                                      .seekTo(
                                    Duration(
                                      seconds: value.toInt(),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  )
                : const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
          },
        );
      },
    );
  }
}
