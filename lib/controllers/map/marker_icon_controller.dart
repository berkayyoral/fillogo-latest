import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/widgets/shild_icon_pinned.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'package:fillogo/export.dart';
import 'package:image_to_byte/image_to_byte.dart';

class SetCustomMarkerIconController extends GetxController {
  Uint8List? myFriendsLocation;
  Uint8List? myFriendsLocationPic;
  Uint8List? mayLocationIcon;
  Uint8List? myRouteFinishIcon;
  Uint8List? myRouteStartIcon;
  Uint8List? myRouteStartIconnoSee;
  Widget? myLocation;

  @override
  void onInit() async {
    await setCustomMarkerIcon3(); //myLocationIcon
    await setCustomMarkerIcon(); //myRouteStartIcon
    await setCustomMarkerIcon2(); //myfriendLocationIcon
    await setCustomMarkerIconNoSee(); //myRouteStartIcon (baştakiyle aynı)
    await setCustomMarkerIcon4(); //bitisIcon6
    super.onInit();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    print("cartypem");
    ByteData data = await rootBundle.load(path);
    print("cartypem data -> $data");
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 130);
    ui.FrameInfo fi = await codec.getNextFrame();
    print("cartype getby ");
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List> getBytesFromNetwork(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 130);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  setCustomMarkerIconNoSee() async {
    myRouteStartIconnoSee =
        await getBytesFromAsset('assets/icons/myRouteStartIcon.png', 1);
  }

  setCustomMarkerIcon() async {
    myRouteStartIcon =
        await getBytesFromAsset('assets/icons/myRouteStartIcon.png', 100);
  }

  setCustomMarkerIcon2() async {
    myFriendsLocation =
        await getBytesFromAsset('assets/icons/myFriendLocationIcon.png', 100);
  }

  setCustomMarkerIcon3({bool isOffVisibility = false}) async {
    String? myCarType =
        LocaleManager.instance.getString(PreferencesKeys.carType);

    isOffVisibility =
        LocaleManager.instance.getBool(PreferencesKeys.isVisibility)!;
    print(" iconcont visib -> ${isOffVisibility}");
    String iconPath;
    if (myCarType != null) {
      if (!isOffVisibility) {
        iconPath = myCarType == "Otomobil"
            ? 'assets/icons/myLocationOffVisibilityLightCommercial.png'
            : myCarType == "Tır"
                ? 'assets/icons/myLocationOffVisibilityTruck.png'
                : 'assets/icons/myLocationOffVisibilityMotorcycle.png';
      } else {
        iconPath = myCarType == "Otomobil"
            ? 'assets/icons/myLocationLightCommercial.png'
            : myCarType == "Tır"
                ? 'assets/icons/myLocationTruck.png'
                : 'assets/icons/myLocationMotorcycle.png';
      }
      print("VİSİVİBİLTRMARKER iconpath -> ${iconPath}");
      mayLocationIcon = await getBytesFromAsset(iconPath, 100);
    } else {
      mayLocationIcon =
          await getBytesFromAsset('assets/icons/myLocationIcon.png', 100);
    }

    // await getBytesFromAsset('assets/icons/myLocationIcon.png', 100);
  }

  setCustomMarkerIcon4() async {
    myRouteFinishIcon =
        await getBytesFromAsset('assets/icons/bitisIcon6.png', 200);
  }

  setCustomMarkerIcon5(String url) async {
    myFriendsLocationPic = await imageToByte(url);
  }

  setCustomMarkerIcon6(String url) async {
    myLocation = ClipPath(
      clipper: ShildIconCustomPainter(),
      child: Container(
        height: 100,
        width: 100,
        color: AppConstants().ltWhite,
        child: Image.network(
          url ??
              'https://res.cloudinary.com/dmpfzfgrb/image/upload/v1680248743/fillogo/user_yxtelh.png',
          fit: BoxFit.cover,
        ),
      ),
    );

    // mayLocationIcon = (await NetworkAssetBundle(Uri.parse(LocaleManager.instance
    //             .getString(PreferencesKeys.currentUserProfilPhoto)!))
    //         .load(LocaleManager.instance
    //             .getString(PreferencesKeys.currentUserProfilPhoto)!))
    //     .buffer
    //     .asUint8List();

    mayLocationIcon =
        await getBytesFromAsset('assets/icons/myLocationIcon.png', 100);
  }

  Future<Uint8List> friendsCustomMarkerIcon({required CarType carType}) async {
    Uint8List? iconByCarType;
    String iconPath;
    switch (carType) {
      case CarType.motorsiklet:
        iconPath = 'assets/icons/friendsLocationMotorcycle.png';
        break;
      case CarType.tir:
        iconPath = 'assets/icons/friendsLocationTruck.png';
        break;
      case CarType.otomobil:
        iconPath = 'assets/icons/friendsLocationLightCommercial.png';
        break;
    }

    iconByCarType = await getBytesFromAsset(iconPath, 100);

    return iconByCarType;
  }
}
