import 'dart:convert';

import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/notification/get_notification_model.dart';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/services/notificaiton_service/local_notification/local_notification_service.dart';
import 'package:fillogo/services/notificaiton_service/one_signal_notification/one_signal_notification_service.dart';
import 'package:fillogo/services/socket/socket_service.dart';
import 'package:fillogo/views/notifications_view/components/notification_widget.dart';
import 'package:fillogo/views/notifications_view/components/title_widget.dart';
import 'package:fillogo/views/route_details_page_view/components/start_end_adress_controller.dart';

class NotificationsView extends StatelessWidget {
  NotificationsView({Key? key}) : super(key: key);

  NotificationController notificationController =
      Get.put(NotificationController());

  StartEndAdressController startEndAdressController =
      Get.find<StartEndAdressController>();

  BottomNavigationBarController bottomNavigationBarController =
      Get.find<BottomNavigationBarController>();

  var isFollow1 = 1.obs;
  var isFollow2 = 0.obs;
  var isFollow4 = 1.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(
              left: 20.w,
              right: 2.w,
            ),
            child: SvgPicture.asset(
              height: 20.h,
              width: 20.w,
              'assets/icons/back-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Text(
          "Bildirimler",
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20.sp,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 20.w,
            bottom: 30.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder<GetNotificationResponseModel?>(
                future: GeneralServicesTemp().makeGetRequest(
                  EndPoint.getNotifications,
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
                    'Content-Type': 'application/json',
                  },
                ).then((value) {
                  if (value != null) {
                    return GetNotificationResponseModel.fromJson(
                        json.decode(value));
                  }
                  return null;
                }),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return (snapshot.data!.data![0].formatted!.today!.isEmpty &&
                            snapshot
                                .data!.data![0].formatted!.thisWeek!.isEmpty &&
                            snapshot
                                .data!.data![0].formatted!.thisMonth!.isEmpty &&
                            snapshot.data!.data![0].formatted!.older!.isEmpty)
                        ? Center(
                            child: GestureDetector(
                            onTap: () {
                              getNotificationData();
                              SocketService.instance().socket.emit(
                                  'notification',
                                  NotificationModel(
                                    sender: LocaleManager.instance
                                        .getInt(PreferencesKeys.currentUserId),
                                    receiver: LocaleManager.instance
                                        .getInt(PreferencesKeys.currentUserId),
                                    type: 1,
                                    params: [],
                                    message: NotificaitonMessage(
                                      text: NotificationText(
                                      content: "adlı kullanıcı seni takip etti.",
                                      name: LocaleManager.instance
                                    .getString(PreferencesKeys.currentUserUserName),
                                        surname: "surname" ?? "",
                                        username: "username" ?? "",
                                      ),
                                      link: "",
                                    ),
                                  ));
                            },
                            child: const Text(
                                "Henüz Bildiriminiz Bulunmamaktadır."),
                          ))
                        : Column(
                            children: [
                              snapshot.data!.data![0].formatted!.today!
                                      .isNotEmpty
                                  ? timeAndNotificationListItem(
                                      notificationList: snapshot.data!.data![0]
                                          .formatted!.today!.reversed
                                          .toList(),
                                      time: "Bugün")
                                  : const SizedBox(),
                              snapshot.data!.data![0].formatted!.thisWeek!
                                      .isNotEmpty
                                  ? timeAndNotificationListItem(
                                      notificationList: snapshot.data!.data![0]
                                          .formatted!.thisWeek!.reversed
                                          .toList(),
                                      time: "Bu hafta")
                                  : const SizedBox(),
                              snapshot.data!.data![0].formatted!.thisMonth!
                                      .isNotEmpty
                                  ? timeAndNotificationListItem(
                                      notificationList: snapshot.data!.data![0]
                                          .formatted!.thisMonth!.reversed
                                          .toList(),
                                      time: "Bu ay")
                                  : const SizedBox(),
                              snapshot.data!.data![0].formatted!.older!
                                      .isNotEmpty
                                  ? timeAndNotificationListItem(
                                      notificationList: snapshot.data!.data![0]
                                          .formatted!.older!.reversed
                                          .toList(),
                                      time: "Daha Eski")
                                  : const SizedBox(),
                            ],
                          );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
              30.h.spaceY,
            ],
          ),
        ),
      ),
    );
  }

  Widget timeAndNotificationListItem({
    List<Older>? notificationList,
    required String time,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          title: time,
        ),
        10.h.spaceY,
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notificationList!.length,
            itemBuilder: (context, index) {
              return NotificationWidget(
                notificationType: notificationList[index].type!,
                name: notificationList[index].username!,
                profilePhotoUrl:
                    notificationList[index].sender!.profilePicture.toString(),
                postPhotoUrl: notificationList[index].link.toString(),
                onTap: () {
                  if (notificationList[index].type! == 1) {
                    // getNotificationData();
                    SocketService.instance().socket.emit(
                        'notification',
                        NotificationModel(
                          sender: LocaleManager.instance
                              .getInt(PreferencesKeys.currentUserId),
                          receiver: notificationList[index].sender!.id,
                          type: 1,
                          params: [],
                          message: NotificaitonMessage(
                              text: NotificationText(
                                      content: "adlı kullanıcı seni takip etti.",
                                      name: LocaleManager.instance
                                    .getString(PreferencesKeys.currentUserUserName),
                                surname: "surname" ?? "",
                                username:
                                    notificationList[index].sender!.username ??
                                        "",
                              ),
                              link: '/user/user_profile/'
                                  '${notificationList[index].sender!.id}' //,
                              ),
                        ));
                    LocalNotificationService()
                        .showNotification(title: " bbb", body: "aaa");
                  } else if (notificationList[index].type! == 2) {
                    startEndAdressController.startAdress.value = 'İstanbul';
                    startEndAdressController.endAdress.value = 'Samsun';
                    Get.toNamed('/routeDetails');
                    print("Yolculuğu Aç");
                  } else if (notificationList[index].type! == 3) {
                    Get.toNamed(NavigationConstants.comments,
                        arguments: notificationList[index].params![0]);
                  } else {
                    Get.toNamed(NavigationConstants.comments,
                        arguments: notificationList[index].params![0]);
                  }
                },
                nameOnTap: () {
                  Get.toNamed('/otherprofiles',
                      arguments: notificationList[index].sender!.id);
                },
                profilePhotoOnTap: () {
                  Get.toNamed('/otherprofiles',
                      arguments: notificationList[index].sender!.id);
                },
                color: AppConstants().ltLogoGrey,
              );
            }),
      ],
    );
  }

  void getNotificationData() {
    SocketService.instance().socket.on('get-notification', (data) async {
      print("GET NOTIFICATION DATA = $data");
    });
  }

  void pushNotfication() async {
    LocalNotificationService().pushNotification(
        receiver: 11, type: 1, name: "deneme", content: "inş olur", params: []);
  }

  void oneSignalStart() async {
    OneSignalNotificationService();
    OneSignalNotificationService().handleClickNotification();
  }
}

//NotificationTypes 
//  1 = takip etmeye başladı
//  2 = Yolculuğa başladı
//  3 = Gönderine yorum yaptı
//  4 = Gönderini beğendi
//  10 = Rota başlıyor ya da 1 saat kaldı
//  99 = Selektör atma



/*
GestureDetector(
                onTap: () async {
                  startEndAdressController.startAdress.value = 'İstanbul';
                  startEndAdressController.endAdress.value = 'Samsun';
                  Get.toNamed('/routeDetails');
                },
                child: Container(
                  width: 340.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppConstants().ltWhiteGrey,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: ProfilePhoto(
                          onTap: () {
                            print("Hikayeye Yönlendir");
                          },
                          height: 48.h,
                          width: 48.w,
                          url: 'https://picsum.photos/150',
                        ),
                      ),
                      SizedBox(
                        width: 222.w,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    print("Profile Yönlendir");
                                    //TODO: 69.SATIRDAKİ GESTURE DETECTOR SEBEBİYLE TIKLANMIYOR
                                  },
                                text: 'İnanç Telci    ',
                                style: TextStyle(
                                    fontFamily: 'Sfbold',
                                    color: AppConstants().ltLogoGrey),
                              ),
                              TextSpan(
                                text:
                                    'adlı kullanıcı yeni bir yolculuğa başladı',
                                style: TextStyle(
                                  fontFamily: 'Sfmedium',
                                  color: AppConstants().ltDarkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SvgPicture.asset(
                        'assets/icons/route-icon.svg',
                        height: 30.h,
                        width: 30.w,
                        color: AppConstants().ltMainRed,
                      ),
                    ],
                  ),
                ),
              ),*/




//TODO: HOW TO SEND NOTIFICATION
              /* GestureDetector(
                onTap: () async {
                  // Get.toNamed("/comments");
                  getNotificationData();
                  SocketService.instance().socket.emit(
                      'notification',
                      NotificationModel(
                        sender: LocaleManager.instance
                            .getInt(PreferencesKeys.currentUserId),
                        receiver: 5,
                        type: 1,
                        params: [],
                        message: NotificaitonMessage(
                          text: NotificationText(
                            content: "content",
                            name: "name",
                            surname: "surname" ?? "",
                            username: "username" ?? "",
                          ),
                          link: "",
                        ),
                      ));
                  LocalNotificationService()
                      .showNotification(title: " bbb", body: "aaa");
                },
                child: Container(
                  width: 340.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppConstants().ltWhiteGrey,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: ProfilePhoto(
                          height: 48.h,
                          width: 48.w,
                          url: 'https://picsum.photos/150',
                        ),
                      ),
                      SizedBox(
                        width: 222.w,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Furkan Semiz    ',
                                style: TextStyle(
                                    fontFamily: 'Sfbold',
                                    color: AppConstants().ltLogoGrey),
                              ),
                              TextSpan(
                                text: 'adlı kullanıcı gönderine yorum yaptı',
                                style: TextStyle(
                                  fontFamily: 'Sfmedium',
                                  color: AppConstants().ltDarkGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Image.network(
                        'https://picsum.photos/150',
                        height: 40.h,
                        width: 40.w,
                      ),
                    ],
                  ),
                ),
              ),*/