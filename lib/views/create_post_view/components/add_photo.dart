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

class AddPhoto extends StatefulWidget {
  const AddPhoto({
    super.key,
  });

  @override
  State<AddPhoto> createState() => _AddPhotoState();
}

class _AddPhotoState extends State<AddPhoto> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    return imageFile == null
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
                "Fotoğraf veya gönderi eklemek için bir kaynak seçiniz",
            onPressed1: () async {
              imageFile = await BussinessHelper.pickImage(
                context,
                ImageSource.camera,
                [CropAspectRatioPreset.ratio16x9],
                const CropAspectRatio(ratioX: 16, ratioY: 9),
              ).then((value) {
                return value;
              });
              setState(() {});
            },
            onPressed2: () async {
              imageFile = await BussinessHelper.pickImage(
                context,
                ImageSource.gallery,
                [CropAspectRatioPreset.ratio16x9],
                const CropAspectRatio(ratioX: 16, ratioY: 9),
              ).then((value) {
                return value;
              });
              setState(() {});
            },
            title: 'Fotoğraf / Video Seç',
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
                    // UiHelper.showLoadingAnimation(context);
                    // Map<String, dynamic> formData = {
                    //   'file': imageFile,
                    // };
                    // await GeneralServicesTemp().makePostRequestWithFormData(
                    //   EndPoint.updateBanner,
                    //   formData,
                    //   {
                    //     "Content-Type": "multipart/form-data",
                    //     'Authorization':
                    //         'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                    //   },
                    // ).then((value) {
                    //   if (value != null) {
                    //     final response =
                    //         UpdateProfilePictureResponseModel.fromJson(
                    //             jsonDecode(value));
                    //     if (response.success == 1) {
                    //       Get.back();
                    //       Get.back();
                    //       futureController
                    //           .updatePagesByID([PageIDs.myProfile]);
                    //     }
                    //   }
                    // });
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
          );
  }
}
