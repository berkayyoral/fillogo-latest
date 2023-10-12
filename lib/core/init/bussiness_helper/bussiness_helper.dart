import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:fillogo/controllers/media/media_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_compress/video_compress.dart';

class BussinessHelper {
  static Future<File?> pickImage(
    BuildContext context,
    ImageSource imageSource,
    List<CropAspectRatioPreset> aspectRatioPresets,
    CropAspectRatio? aspectRatio,
  ) async {
    UiHelper.showLoadingAnimation(context);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: imageSource,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: aspectRatioPresets,
        compressQuality: 90,
        aspectRatio: aspectRatio,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: AppConstants().ltMainRed,
            activeControlsWidgetColor: AppConstants().ltMainRed,
            toolbarWidgetColor: AppConstants().ltWhite,
            hideBottomControls: true,
            lockAspectRatio: true,
          ),
          IOSUiSettings(
            rotateButtonsHidden: true,
            resetButtonHidden: true,
            aspectRatioPickerButtonHidden: true,
            aspectRatioLockEnabled: true,
          ),
        ],
      );
      Get.back();
      if (croppedFile != null) {
        return File(croppedFile.path);
      } else {
        return null;
      }
    }
    return null;
  }

  static Future<PlatformFile?> pickFile(BuildContext context) async {
    MediaPickerController mediaPickerController = Get.find();
    CreatePostPageController createPostPageController =
        Get.find<CreatePostPageController>();
    UiHelper.showLoadingAnimation(context);
    final response = await FilePicker.platform.pickFiles(
      type: FileType.media,
      allowMultiple: false,
    );

    if (response != null) {
      if (response.files.first.name.endsWith('.png') ||
          response.files.first.name.endsWith('.jpg') ||
          response.files.first.name.endsWith('.mp4') ||
          response.files.first.name.endsWith('.jpeg')) {
        if (response.files.first.size > 20000000) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'Dosya boyutu çok yüksek. Dosya en fazla 20MB olabilir.'),
            ),
          );
          Get.back();

          return null;
        }
        if (!response.files.first.name.endsWith('.mp4')) {
          log('response size ${response.files.first.size * (1 / 1000000)} + ${response.files.first.name}');
          CroppedFile? croppedFile = await ImageCropper().cropImage(
            sourcePath: response.files.first.path!,
            aspectRatioPresets: [CropAspectRatioPreset.ratio4x3],
            compressQuality: 90,
            aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3),
            uiSettings: [
              AndroidUiSettings(
                toolbarColor: Colors.red,
                activeControlsWidgetColor: Colors.red,
                toolbarWidgetColor: Colors.white,
                hideBottomControls: true,
                lockAspectRatio: true,
              ),
              IOSUiSettings(
                rotateButtonsHidden: true,
                resetAspectRatioEnabled: false,
                aspectRatioLockEnabled: true,
                resetButtonHidden: true,
              ),
            ],
          );
          var platformFile = PlatformFile(
            path: croppedFile!.path,
            name: response.files.first.name,
            size: await croppedFile.readAsBytes().then((value) {
              log((value.length * (1 / 1000000)).toString());
              return value.length;
            }),
          );
          Get.back();

          return platformFile;
        } else {
          log('first size ${response.files.first.size}');

          MediaInfo? media = await VideoCompress.compressVideo(
            response.files.first.path!,
            quality: VideoQuality.MediumQuality,
            deleteOrigin: false,
          ).then((value) async {
            return value;
          });
          if (media != null) {
            await VideoCompress.getFileThumbnail(media.path!,
                    quality: 50, position: -1)
                .then(
              (value) {
                mediaPickerController.fileName = value.path.split('/').last;
                mediaPickerController.filePath = value.path;
                log(value.path);
              },
            );
            log('last size ${media.filesize}');
            Get.back();

            return PlatformFile(
              name: media.file!.path.split('/').last,
              size: media.filesize!,
              path: media.file!.path,
            );
          } else {
            return response.files.first;
          }
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Bu dosya biçimi desteklenmiyor...'),
          ),
        );
        Get.back();

        return null;
      }
    } else {
      createPostPageController.clearPostCreateInfoController();
      Get.back();

      return null;
    }
  }
}
