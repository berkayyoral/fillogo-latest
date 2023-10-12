import 'package:file_picker/file_picker.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';

import '../../export.dart';

class MediaPickerController extends GetxController {
  @override
  void onClose() {
    CreatePostPageController createPostPageController = Get.find();
    createPostPageController.clearPostCreateInfoController();
    super.onClose();
  }

  PlatformFile? media;

  final _isVideo = false.obs;
  get isVideo => _isVideo.value;
  set isVideo(value) => _isVideo.value = value;

  final _isMediaPicked = false.obs;
  get isMediaPicked => _isMediaPicked.value;
  set isMediaPicked(value) => _isMediaPicked.value = value;

  final _filePath = ''.obs;
  get filePath => _filePath.value;
  set filePath(value) => _filePath.value = value;

  final _fileName = ''.obs;
  get fileName => _fileName.value;
  set fileName(value) => _fileName.value = value;
}
