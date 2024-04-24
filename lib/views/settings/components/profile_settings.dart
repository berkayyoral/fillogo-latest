import 'dart:convert';

import 'package:fillogo/models/user/profile/update_user_profile.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';

import '../../../export.dart';
import '../../../widgets/popup_view_widget.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  int dropdownValue = 0;
  List<DropdownMenuItem<int>> aracTipleri = [
    DropdownMenuItem<int>(
      value: 0,
      child: Text(
        'Tır',
        style: TextStyle(
          fontFamily: "Sfregular",
          fontSize: 12.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    ),
    DropdownMenuItem<int>(
      value: 1,
      child: Text(
        'Hafif Ticari',
        style: TextStyle(
          fontFamily: "Sfregular",
          fontSize: 12.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    ),
    DropdownMenuItem<int>(
      value: 2,
      child: Text(
        'Motokurye',
        style: TextStyle(
          fontFamily: "Sfregular",
          fontSize: 12.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    ),
  ];

  TextEditingController userNameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    userNameController.text = LocaleManager.instance
        .getString(PreferencesKeys.currentUserUserName)
        .toString();
    nameController.text = LocaleManager.instance
        .getString(PreferencesKeys.currentUserName)
        .toString();
    surNameController.text = LocaleManager.instance
        .getString(PreferencesKeys.currentUserSurname)
        .toString();
    mailController.text = LocaleManager.instance
        .getString(PreferencesKeys.currentUserMail)
        .toString();
    phoneController.text = LocaleManager.instance
        .getString(PreferencesKeys.currentUserPhone)
        .toString();

    return Scaffold(
      appBar: AppBarGenel(
        title: Text(
          'Profil Ayarları',
          style: TextStyle(
              fontFamily: 'Sfsemibold',
              color: AppConstants().ltLogoGrey,
              fontSize: 28),
        ),
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SvgPicture.asset(
                'assets/icons/back-icon.svg',
                color: AppConstants().ltLogoGrey,
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _textField(
                    controller: userNameController,
                    hint: 'Kullanıcı Adı',
                  ),
                  _textField(
                    controller: nameController,
                    hint: 'İsim',
                  ),
                  _textField(
                    controller: surNameController,
                    hint: 'Soyisim',
                  ),
                  // _textField(
                  //   controller: phoneController,
                  //   hint: 'Telefon',
                  // ),
                  _textField(
                    controller: mailController,
                    hint: 'Eposta',
                  ),
                  20.h.spaceY,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        'Şifre',
                        style: TextStyle(
                          fontFamily: 'Sfsemibold',
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  10.h.spaceY,
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(
                        NavigationConstants.changePassView,
                      );
                    },
                    child: Container(
                      width: 340.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        enabled: false,
                        cursorColor: AppConstants().ltMainRed,
                        decoration: InputDecoration(
                          hintText: 'Şifre değiştir',
                          hintStyle: TextStyle(
                            fontFamily: "Sfregular",
                            fontSize: 12.sp,
                            color: AppConstants().ltDarkGrey,
                          ),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          suffixIcon: const Icon(Icons.arrow_forward_rounded),
                        ),
                        style: TextStyle(
                          fontFamily: "Sfregular",
                          fontSize: 12.sp,
                          color: AppConstants().ltBlack,
                        ),
                      ),
                    ),
                  ),
                  40.h.spaceY,
                  RedButton(
                    text: 'Kaydet',
                    onpressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) =>
                            ShowAllertDialogWidget(
                          button1Color: AppConstants().ltMainRed,
                          button1Height: 50.h,
                          button1IconPath: '',
                          button1Text: 'Kaydet',
                          button1TextColor: AppConstants().ltWhite,
                          button1Width: Get.width,
                          button2Color: AppConstants().ltDarkGrey,
                          button2Height: 50.h,
                          button2IconPath: '',
                          button2Text: 'Kaydetme',
                          button2TextColor: AppConstants().ltWhite,
                          button2Width: Get.width,
                          buttonCount: 2,
                          discription1:
                              "Profil değişiklikleriniz kaydedilsin mi?",
                          onPressed1: () {
                            //print(updateUserProfileRequest.toJson());

                            GeneralServicesTemp().makePatchRequest(
                                EndPoint.updateProfile,
                                UpdateUserProfileRequest(
                                    username: userNameController.text,
                                    name: nameController.text,
                                    surname: surNameController.text,
                                    mail: mailController.text,
                                    phoneNumber: phoneController.text),
                                {
                                  "Content-type": "application/json",
                                  'Authorization':
                                      'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                }).then((value) {
                              var response = UpdateProfileResponse.fromJson(
                                  json.decode(value!));
                              if (response.success == 1) {
                                Get.offAndToNamed(
                                    NavigationConstants.bottomNavigationBar);
                                LocaleManager.instance.setString(
                                    PreferencesKeys.currentUserUserName,
                                    userNameController.text);
                                LocaleManager.instance.setString(
                                    PreferencesKeys.currentUserName,
                                    nameController.text);
                                LocaleManager.instance.setString(
                                    PreferencesKeys.currentUserSurname,
                                    surNameController.text);
                                LocaleManager.instance.setString(
                                    PreferencesKeys.currentUserMail,
                                    mailController.text);
                                LocaleManager.instance.setString(
                                    PreferencesKeys.currentUserPhone,
                                    phoneController.text);
                              } else {
                                print(response.success);
                                print(response.message);
                                UiHelper.showWarningSnackBar(context,
                                    "Bir hata ile karşılaşıldı Tekrar Deneyiniz!");
                              }
                            });
                          },
                          onPressed2: () {
                            Get.back();
                          },
                          title: 'Profil Ayarları',
                        ),
                      );
                    },
                  ),
                  40.h.spaceY,
                ],
              ),
            );
          }),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hint,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hint,
            style: TextStyle(
              fontFamily: 'Sfsemibold',
              fontSize: 16.sp,
            ),
          ),
          10.h.spaceY,
          Container(
            width: 340.w,
            height: 50.h,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              cursorColor: AppConstants().ltMainRed,
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  fontFamily: "Sfregular",
                  fontSize: 12.sp,
                  color: AppConstants().ltDarkGrey,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              style: TextStyle(
                fontFamily: "Sfregular",
                fontSize: 12.sp,
                color: AppConstants().ltBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
