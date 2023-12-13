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
    await setCustomMarkerIcon();
    await setCustomMarkerIcon2();
    await setCustomMarkerIcon3();
    await setCustomMarkerIcon4();
    super.onInit();
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future<Uint8List> getBytesFromNetwork(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
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

  setCustomMarkerIcon3() async {
    myLocation = ClipPath(
      clipper: ShildIconCustomPainter(),
      child: Container(
        height: 100,
        width: 100,
        color: AppConstants().ltWhite,
        child: Image.network(
          LocaleManager.instance
                  .getString(PreferencesKeys.currentUserProfilPhoto)! ??
              'https://res.cloudinary.com/dmpfzfgrb/image/upload/v1680248743/fillogo/user_yxtelh.png',
          fit: BoxFit.cover,
        ),
      ),
    );

    mayLocationIcon = (await NetworkAssetBundle(Uri.parse(LocaleManager.instance
                .getString(PreferencesKeys.currentUserProfilPhoto)!))
            .load(LocaleManager.instance
                .getString(PreferencesKeys.currentUserProfilPhoto)!))
        .buffer
        .asUint8List();

    mayLocationIcon =
        await getBytesFromAsset('assets/icons/myLocationIcon.png', 100);
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

    mayLocationIcon = (await NetworkAssetBundle(Uri.parse(LocaleManager.instance
                .getString(PreferencesKeys.currentUserProfilPhoto)!))
            .load(LocaleManager.instance
                .getString(PreferencesKeys.currentUserProfilPhoto)!))
        .buffer
        .asUint8List();

    mayLocationIcon =
        await getBytesFromAsset('assets/icons/myLocationIcon.png', 100);
  }
}
