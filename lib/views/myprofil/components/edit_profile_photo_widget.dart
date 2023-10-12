import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:fillogo/controllers/future_controller.dart';
import 'package:fillogo/core/init/bussiness_helper/bussiness_helper.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/profile/update_pp_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/widgets/custom_red_button.dart';
import 'package:fillogo/widgets/popup_view_widget.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' as parser;

class EditProfilePhoto extends StatefulWidget {
  EditProfilePhoto({
    super.key,
  });

  @override
  State<EditProfilePhoto> createState() => _EditProfilePhotoState();
}

class _EditProfilePhotoState extends State<EditProfilePhoto> {
  File? imageFile;
  final FutureController futureController = Get.find<FutureController>();
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 800),
      child: imageFile == null
          ? ShowAllertDialogWidget(
              button1Color: AppConstants().ltMainRed,
              button1Height: 50.h,
              button1IconPath: '',
              button1Text: 'Kamera',
              button1TextColor: AppConstants().ltWhite,
              button1Width: Get.width,
              button2Color: AppConstants().ltDarkGrey,
              button2Height: 50.h,
              button2IconPath: '',
              button2Text: 'Galeri',
              button2TextColor: AppConstants().ltWhite,
              button2Width: Get.width,
              buttonCount: 2,
              discription1:
                  "Kapak fotoğrafınızı değiştirmek için bir kaynak seçiniz",
              onPressed1: () async {
                imageFile = await BussinessHelper.pickImage(
                  context,
                  ImageSource.camera,
                  [CropAspectRatioPreset.square],
                  const CropAspectRatio(ratioX: 1, ratioY: 1),
                ).then((value) {
                  return value;
                });
                setState(() {});
              },
              onPressed2: () async {
                imageFile = await BussinessHelper.pickImage(
                  context,
                  ImageSource.gallery,
                  [CropAspectRatioPreset.square],
                  const CropAspectRatio(ratioX: 1, ratioY: 1),
                ).then((value) {
                  return value;
                });
                setState(() {});
              },
              title: 'Kapak Fotoğrafı',
            )
          : AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 256.w,
                    height: 256.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: FileImage(imageFile!),
                      ),
                    ),
                  ),
                  16.h.spaceY,
                  CustomRedButton(
                    title: 'Kaydet',
                    onTap: () async {
                      UiHelper.showLoadingAnimation(context);
                      Map<String, dynamic> formData = {
                        'file': imageFile,
                      };
                      await GeneralServicesTemp().makePatchRequestWithFormData(
                        EndPoint.updateProfilePicture,
                        formData,
                        {
                          "Content-Type": "multipart/form-data",
                          'Authorization':
                              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                        },
                      ).then((value) {
                        if (value != null) {
                          final response =
                              UpdateProfilePictureResponseModel.fromJson(
                                  jsonDecode(value));
                          if (response.success == 1) {
                            Get.back();
                            Get.back();
                            futureController
                                .updatePagesByID([PageIDs.myProfile]);
                          }
                        }
                      });
                    },
                  ),
                  8.h.spaceY,
                  CustomRedButton(
                    title: 'İptal',
                    onTap: () {
                      Get.back();
                      imageFile = null;
                    },
                    buttonColor: AppConstants().ltDarkGrey,
                  ),
                ],
              ),
            ),
    );
  }

  _getFromCamera() async {
    UiHelper.showLoadingAnimation(context);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      log('${pickedFile.path} - ${imageFile!.path}');
      if (imageFile != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: imageFile!.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          compressQuality: 90,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            // AndroidUiSettings(
            //   toolbarColor: ColorConstants.primaryColor,
            //   activeControlsWidgetColor: ColorConstants.primaryColor,
            //   toolbarWidgetColor: ColorConstants.whiteColor,
            //   hideBottomControls: true,
            //   lockAspectRatio: true,
            // ),
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
          imageFile = File(croppedFile.path);
          log(croppedFile.path.toString());
          // _registerController.profilePicture = imageFile;
        }
      }
    }
  }

  _getFromGallery() async {
    UiHelper.showLoadingAnimation(context);
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        CroppedFile? croppedFile = await ImageCropper().cropImage(
          sourcePath: imageFile!.path,
          aspectRatioPresets: [CropAspectRatioPreset.square],
          compressQuality: 90,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            // AndroidUiSettings(
            //   toolbarColor: ColorConstants.primaryColor,
            //   activeControlsWidgetColor: ColorConstants.primaryColor,
            //   toolbarWidgetColor: ColorConstants.whiteColor,
            //   hideBottomControls: true,
            //   lockAspectRatio: true,
            // ),
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
          imageFile = File(croppedFile.path);
          setState(() {});
          log(croppedFile.path.toString());
        }
      }
    }
  }
}
