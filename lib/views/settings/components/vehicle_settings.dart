import 'dart:convert';

import 'package:fillogo/controllers/vehicle_info_controller/vehicle_info_controller.dart';
import 'package:fillogo/models/user/get_user_car_types.dart';
import 'package:fillogo/models/user/profile/update_user_profile.dart';
import 'package:fillogo/models/user/update_user_car_infos.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';

import '../../../controllers/dropdown/dropdown_controller.dart';
import '../../../export.dart';
import '../../../widgets/popup_view_widget.dart';

class VehicleSettings extends StatefulWidget {
  VehicleSettings({Key? key}) : super(key: key);

  @override
  State<VehicleSettings> createState() => _VehicleSettingsState();
}

class _VehicleSettingsState extends State<VehicleSettings> {
  UpdateUserProfileRequest updateUserProfileRequest =
      UpdateUserProfileRequest();
  int? carId;
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

  final DropdownController _dropdownController = Get.put(DropdownController());

  TextEditingController brandController = TextEditingController();
  TextEditingController modelController = TextEditingController();
  TextEditingController capacityController = TextEditingController();

  VehicleInfoController vehicleInfoController = Get.find();

  @override
  void initState() {
    GeneralServicesTemp().makeGetRequest(EndPoint.getUserCarTypes, {
      "Content-type": "application/json",
      'Authorization':
          'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
    }).then((value) {
      var response = GetUserCarTypesResponse.fromJson(json.decode(value!));
      if (response.succes == 1) {
        carId = response.data![0].userCarTypes![0].id;
        brandController.text =
            response.data![0].userCarTypes![0].carBrand.toString();
        modelController.text =
            response.data![0].userCarTypes![0].carModel.toString();

        print(carId);
      } else {
        print("Response Hata = " + response.message.toString());
        print("Response Hata = " + response.succes.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        title: Text(
          'Araç Ayarları',
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
                  20.h.spaceY,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: Text(
                        'Araç Tipi',
                        style: TextStyle(
                          fontFamily: 'Sfsemibold',
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
                  10.h.spaceY,
                  Container(
                    width: 340.w,
                    height: 50.h,
                    padding: const EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                      color: AppConstants().ltWhite,
                    ),
                    child: DropdownButton<int>(
                      style: TextStyle(
                        fontFamily: "Sfregular",
                        fontSize: 12.sp,
                        color: AppConstants().ltBlack,
                      ),
                      icon: const SizedBox(),
                      underline: const SizedBox(),
                      value: dropdownValue,
                      items: aracTipleri,
                      dropdownColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value ?? 0;
                        });
                      },
                    ),
                  ),
                  _textField(
                    controller: brandController,
                    hint: 'Araç Markası',
                  ),
                  _textField(
                    controller: modelController,
                    hint: 'Araç Modeli',
                  ),
                  _textFieldNumeric(
                    controller: capacityController,
                    hint: 'Araç Kapasitesi',
                  ),
                  40.h.spaceY,
                  RedButton(
                    text: 'Kaydet',
                    onpressed: () {
                      if (capacityController.text.isEmpty) {
                        UiHelper.showWarningSnackBar(
                            context, "Lütfen araç kapasitesini doldurunuz!");
                      } else if (!capacityController.text.isNum) {
                        print(capacityController.text);
                      } else {
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
                                "Araç değişiklikleriniz kaydedilsin mi?",
                            onPressed1: () {
                              GeneralServicesTemp().makePatchRequest(
                                  EndPoint.updateUserCarInfos,
                                  UpdateUserCarInfosRequest(
                                      carId: carId,
                                      carBrand: brandController.text,
                                      carModel: modelController.text,
                                      carCapacity:
                                          int.tryParse(capacityController.text),
                                      plateNumber:
                                          LocaleManager.instance.getString(
                                        PreferencesKeys.plateNumber,
                                      ),
                                      carTypeId: dropdownValue + 1),
                                  {
                                    "Content-type": "application/json",
                                    'Authorization':
                                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                                  }).then((value) {
                                var response =
                                    UpdateUserCarInfosResponse.fromJson(
                                        json.decode(value!));
                                if (response.success == 1) {
                                  Get.offAndToNamed(
                                      NavigationConstants.bottomNavigationBar);
                                  LocaleManager.instance.setString(
                                      PreferencesKeys.carBrand,
                                      brandController.text);
                                  LocaleManager.instance.setString(
                                      PreferencesKeys.carModel,
                                      modelController.text);
                                  LocaleManager.instance.setInt(
                                      PreferencesKeys.carCapacity,
                                      int.tryParse(capacityController.text)!);

                                  LocaleManager.instance.setInt(
                                      PreferencesKeys.carTypeId,
                                      dropdownValue + 1);
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
                      }
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

  Widget _textFieldNumeric({
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
              keyboardType: TextInputType.phone,
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
