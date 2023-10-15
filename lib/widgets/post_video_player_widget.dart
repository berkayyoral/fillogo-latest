import 'package:fillogo/export.dart';
import 'package:video_player/video_player.dart';

class PostVideoPlayerWidget extends StatefulWidget {
  const PostVideoPlayerWidget({Key? key, required this.path}) : super(key: key);

  final String path;

  @override
  State<PostVideoPlayerWidget> createState() => _PostVideoPlayerWidgetState();
}

class _PostVideoPlayerWidgetState extends State<PostVideoPlayerWidget> {
  final RxDouble _sliderPosition = (0.0).obs;
  double get sliderPosition => _sliderPosition.value;
  set sliderPosition(double value) => _sliderPosition.value = value;

  final RxBool _isPlaying = false.obs;
  bool get isPlaying => _isPlaying.value;
  set isPlaying(value) => _isPlaying.value = value;

  final RxBool _isInitialized = false.obs;
  bool get isInitialized => _isInitialized.value;
  set isInitialized(value) => _isInitialized.value = value;

  late VideoPlayerController videoPlayerController;
  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.path)
      ..initialize().then((_) {
        isInitialized = videoPlayerController.value.isInitialized;
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      });
    videoPlayerController.addListener(() {
      isPlaying = videoPlayerController.value.isPlaying;
      sliderPosition =
          videoPlayerController.value.position.inSeconds.toDouble();
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return isInitialized
            ? AspectRatio(
                aspectRatio: videoPlayerController.value.aspectRatio,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: GestureDetector(
                        onTap: isPlaying
                            ? () {
                                videoPlayerController.pause();
                              }
                            : () {
                                videoPlayerController.play();
                              },
                        child: VideoPlayer(videoPlayerController),
                      ),
                    ),
                    isPlaying
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: isPlaying
                                ? () {
                                    videoPlayerController.pause();
                                  }
                                : () {
                                    videoPlayerController.play();
                                  },
                            child: Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_arrow_rounded,
                                size: 40.r,
                                color: AppConstants().ltWhite,
                                shadows: [
                                  BoxShadow(
                                    offset: const Offset(4, 4),
                                    blurRadius: 20,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
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
                              activeTrackColor: AppConstants().ltWhite,
                              inactiveTrackColor: AppConstants().ltBlack,
                              thumbColor: AppConstants().ltDarkGrey,
                              overlayColor: AppConstants().ltWhite,
                            ),
                            child: Obx(() {
                              return Slider(
                                min: 0.0,
                                max: videoPlayerController
                                    .value.duration.inSeconds
                                    .toDouble(),
                                value: sliderPosition,
                                onChanged: (value) {
                                  videoPlayerController.seekTo(
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
                    ),
                  ],
                ),
              )
            : Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator.adaptive(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppConstants().ltMainRed),
                ),
              );
      },
    );
  }
}
