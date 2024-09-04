import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/controllers/register/register_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/get_car_types.dart';
import 'package:fillogo/models/user/login/login_model.dart';
import 'package:fillogo/models/user/register/add_vehicle_info_model.dart';
import 'package:fillogo/models/user/register/register_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/notificaiton_service/one_signal_notification/one_signal_notification_service.dart';
import 'package:fillogo/widgets/custom_red_button.dart';
import 'package:flutter/gestures.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AddVehicleInfoWidget extends StatelessWidget {
  AddVehicleInfoWidget({
    super.key,
  });

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController plateController = TextEditingController();
  bool isAlphabetic(String input) {
    // final alphabetic = RegExp(r'^[a-zA-ZğĞüÜıİöÖçÇşŞ]+$');
    final alphabetic = RegExp(r'^[a-zA-ZğĞüÜıİöÖçÇşŞ\s]+$');
    return alphabetic.hasMatch(input);
  }

  bool isValidPlate(String input) {
    final plateRegex = RegExp(r'^[a-zA-Z0-9]+$');
    return plateRegex.hasMatch(input);
  }

  final TextEditingController capacityController = TextEditingController();
  RegisterController registerController = Get.put(RegisterController());
  bool isNumeric(String input) {
    final numericRegex = RegExp(r'^[0-9]+$');
    return numericRegex.hasMatch(input);
  }

  RxInt selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Araç Bilgileri',
                style: TextStyle(
                  fontFamily: FontConstants.sfBlack,
                  fontSize: 35.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                'Araç bilgilerini gir! Arkadaşların profiline bakarak araç bilgilerini görüntüleyebilecek.',
                style: TextStyle(
                  fontFamily: FontConstants.sfLight,
                  fontSize: 16.sp,
                  color: Colors.white,
                ),
              ),
              FutureBuilder<GetCarTypesResponse>(
                  future: GeneralServicesTemp()
                      .makeGetRequest(EndPoint.getCarTypes, {
                    "Content-type": "application/json",
                  }).then((value) {
                    return GetCarTypesResponse.fromJson(json.decode(value!));
                  }),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: 100,
                        width: Get.width * 0.8,
                        child: ListView.builder(
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                snapshot.data!.data![0].carTypesobject!.length,
                            itemBuilder: (context, index) {
                              return Obx(() => Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      color: selectedIndex.value == index
                                          ? AppConstants()
                                              .ltWhite
                                              .withOpacity(0.95)
                                          : AppConstants()
                                              .ltWhiteGrey
                                              .withOpacity(0.5),
                                      onPressed: () {
                                        selectedIndex.value = index;
                                      },
                                      child: SizedBox(
                                        width: 60,
                                        child: Image.asset(index == 0
                                            ? "assets/icons/tirIcon.png"
                                            : index == 1
                                                ? "assets/icons/hafifTicariIcon.png"
                                                : "assets/icons/motorIcon.png"),
                                      ),
                                    ),
                                  ));
                            }),
                      );
                    } else {
                      return const CircularProgressIndicator();
                    }
                  }),
              CustomTextField(
                onChanged: (value) {
                  if (!isAlphabetic(value)) {
                    // Eğer girilen değer alfabetik değilse, son girişi kaldır.
                    brandController.text =
                        brandController.text.substring(0, value.length - 1);
                  }
                },
                textInputAction: TextInputAction.done,
                labelText: 'Marka',
                keyboardType: TextInputType.name,
                controller: brandController,
              ),
              CustomTextField(
                textInputAction: TextInputAction.done,
                labelText: 'Model',
                keyboardType: TextInputType.name,
                controller: modelController,
              ),
              CustomTextField(
                onChanged: (value) {
                  if (!isNumeric(value)) {
                    capacityController.text =
                        value.substring(0, value.length - 1);
                  }
                },
                textInputAction: TextInputAction.done,
                labelText: 'Kapasite (yük kg)',
                controller: capacityController,
                keyboardType: TextInputType.number,
              ),
              CustomTextField(
                textInputAction: TextInputAction.done,
                labelText: 'Plaka',
                controller: plateController,
                inputFormatters: [
                  MaskTextInputFormatter(
                      mask: '#########', filter: {"#": RegExp('[A-Za-z0-9]')}),
                ],
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Gizlilik Politikasını',
                        style: TextStyle(
                          fontFamily: FontConstants.sfSemiBold,
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("object222");
                          }),
                    TextSpan(
                      text: ' ve ',
                      style: TextStyle(
                        fontFamily: FontConstants.sfLight,
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                        text: 'Kullanıcı Sözleşmesini',
                        style: TextStyle(
                          fontFamily: FontConstants.sfSemiBold,
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            print("object222");
                          }),
                    TextSpan(
                      text: ' okudum, onaylıyorum.',
                      style: TextStyle(
                        fontFamily: FontConstants.sfLight,
                        fontSize: 12.sp,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              CustomRedButton(
                onTap: () async {
                  if (brandController.text.isEmpty) {
                    UiHelper.showWarningSnackBar(
                        context, 'Marka boş bırakılamaz');
                  } else if (modelController.text.isEmpty) {
                    UiHelper.showWarningSnackBar(
                        context, 'Model boş bırakılamaz');
                  } else if (plateController.text.isEmpty) {
                    UiHelper.showWarningSnackBar(
                        context, 'Plaka boş bırakılamaz');
                  } else if (capacityController.text.isEmpty) {
                    UiHelper.showWarningSnackBar(
                        context, 'Kapasite boş bırakılamaz');
                  } else if (!isValidPlate(plateController.text)) {
                    UiHelper.showWarningSnackBar(
                        context, 'Geçerli bir plaka giriniz');
                  } else {
                    UiHelper.showLoadingAnimation();
                    GeneralServicesTemp()
                        .makePostRequest(
                      EndPoint.register,
                      RegisterRequestModel(
                        name: registerController.nameController.value,
                        surname: registerController.surNameController.value,
                        password: registerController.passwordController.value,
                        phoneNumberOrMail:
                            registerController.emailController.value,
                      ),
                      ServicesConstants.appJsonWithoutAuth,
                    )
                        .then(
                      (value) async {
                        if (value != null) {
                          final response =
                              RegisterResponseModel.fromJson(jsonDecode(value));
                          if (response.success == 1) {
                            await GeneralServicesTemp()
                                .makePostRequest(
                              EndPoint.login,
                              LoginRequestModel(
                                phoneNumberOrMail:
                                    registerController.emailController.value,
                                password:
                                    registerController.passwordController.value,
                              ),
                              ServicesConstants.appJsonWithoutAuth,
                            )
                                .then((value) async {
                              if (value != null) {
                                final loginResponse =
                                    LoginResponseModel.fromJson(
                                        jsonDecode(value));
                                if (loginResponse.success == 1) {
                                  LocaleManager.instance.setString(
                                    PreferencesKeys.currentUserId,
                                    loginResponse.data![0].user!.id.toString(),
                                  );
                                  // OneSignal().setExternalUserId(loginResponse
                                  //     .data![0].user!.id
                                  //     .toString());
                                  await OneSignalManager.setupOneSignal();
                                  Get.back();
                                  LocaleManager.instance.setCryptedData(
                                    PreferencesKeys.userCredentials,
                                    '${registerController.emailController.value}+${registerController.passwordController.value}',
                                  );
                                  // LocaleManager.instance.setBool(
                                  //     PreferencesKeys.isVisibility,
                                  //     !response.data![0].user!.isInvisible!);
                                  // LocaleManager.instance.setBool(
                                  //     PreferencesKeys.isAvability,
                                  //     response.data![0].user!.isAvailable!);
                                  // print(
                                  //     "VİSİORAVA V -> ${LocaleManager.instance.getBool(PreferencesKeys.isVisibility)}");
                                  LocaleManager.instance.setString(
                                    PreferencesKeys.accessToken,
                                    loginResponse.data![0].tokens!.accessToken!,
                                  );
                                  LocaleManager.instance.setString(
                                    PreferencesKeys.currentUserUserName,
                                    loginResponse.data![0].user!.username!,
                                  );
                                  LocaleManager.instance.setString(
                                    PreferencesKeys.currentUserUserName,
                                    loginResponse.data![0].user!.username!,
                                  );
                                  LocaleManager.instance.setString(
                                    PreferencesKeys.currentUserProfilPhoto,
                                    loginResponse
                                        .data![0].user!.profilePicture!,
                                  );
                                  LocaleManager.instance.setString(
                                    PreferencesKeys.refreshToken,
                                    loginResponse
                                        .data![0].tokens!.refreshToken!,
                                  );

                                  LocaleManager.instance.setBool(
                                      PreferencesKeys.isOnboardViewed, true);

                                  GeneralServicesTemp().makePostRequest(
                                    EndPoint.addUserCarInfo,
                                    AddVehicleInfoRequestModel(
                                      carBrand: brandController.text,
                                      carModel: modelController.text,
                                      carCapacity: int.tryParse(
                                        capacityController.text,
                                      ),
                                      plateNumber: plateController.text,
                                      carTypeID: selectedIndex.value + 1,
                                    ),
                                    {
                                      'Authorization':
                                          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                                      'Content-Type': 'application/json',
                                    },
                                  ).then((value) {
                                    if (value != null) {
                                      final response =
                                          AddVehicleInfoResponseModel.fromJson(
                                              jsonDecode(value));
                                      log(value);
                                      if (response.succes == 1) {
                                        Get.offAndToNamed(NavigationConstants
                                            .bottomNavigationBar);
                                        LocaleManager.instance.setString(
                                            PreferencesKeys.carBrand,
                                            brandController.text);
                                        LocaleManager.instance.setString(
                                            PreferencesKeys.carModel,
                                            modelController.text);
                                        LocaleManager.instance.setInt(
                                          PreferencesKeys.carCapacity,
                                          int.tryParse(
                                            capacityController.text,
                                          )!,
                                        );
                                        LocaleManager.instance.setString(
                                            PreferencesKeys.plateNumber,
                                            plateController.text);
                                        LocaleManager.instance.setInt(
                                            PreferencesKeys.carTypeId,
                                            selectedIndex.value + 1);
                                        String carType =
                                            selectedIndex.value == 0
                                                ? "Tır"
                                                : selectedIndex.value == 1
                                                    ? "Otomobil"
                                                    : "Motorsiklet";
                                        LocaleManager.instance.setString(
                                            PreferencesKeys.carType, carType);
                                        Get.back();

                                        // log(response.data![0].user!.id!.toString());

                                        // LocaleManager.instance.setInt(PreferencesKeys.currentUserId,
                                        //     response.data![0].user!.id!);

                                        // LocaleManager.instance.setString(
                                        //     PreferencesKeys.currentUserUserName,
                                        //     response.data![0].user!.username!);

                                        Get.offAllNamed(NavigationConstants
                                            .bottomNavigationBar);
                                      } else {
                                        UiHelper.showWarningSnackBar(
                                            context, '${response.message}');
                                      }
                                    }
                                  });
                                } else {
                                  UiHelper.showWarningSnackBar(context,
                                      'Bir şeyler ters gitti... Lütfen tekrar deneyiniz.');
                                  Get.back();
                                }
                              }
                            });
                          }
                        }
                      },
                    );
                  }
                },
                title: 'Kabul et ve giriş yap',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
