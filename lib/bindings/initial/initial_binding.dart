import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/chat/global_chat_controller.dart';
import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/future_controller.dart';
import 'package:fillogo/controllers/life_cycle/life_cycle_controller.dart';
import 'package:fillogo/controllers/map/first_login_is_active_route_controller.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/controllers/post_controller/posts_detail_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/controllers/vehicle_info_controller/vehicle_info_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/connection_view/components/connection_controller.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/like_list_view/components/like_controller.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';
import 'package:fillogo/views/route_details_page_view/components/start_end_adress_controller.dart';
import '../../controllers/map/get_current_location_and_listen.dart';
import '../../views/map_page_view/components/map_page_controller.dart';
import '../../views/route_calculate_view/components/create_route_controller.dart';
import '../../views/route_details_page_view/components/selected_route_controller.dart';
import '../../widgets/google_maps_widgets/maps_general_widgets_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() async {
    Get.put(GetMyCurrentLocationController());
    Get.put(ConnectionController());
    Get.put(BerkayController());
    Get.put(SetCustomMarkerIconController());
    Get.put(CreateeRouteController());
    Get.put(MapPageController());
    Get.put(GoogleMapsGeneralWidgetsController());
    Get.put(GeneralDrawerController());
    Get.put(BottomNavigationBarController());
    Get.put(SelectedRouteController());
    Get.put(CreatePostPageController());
    Get.put(StartEndAdressController());
    Get.put(UserStateController());
    Get.put(LifeCycleController());
    Get.put(FutureController());
    Get.put(GlobalChatController());
    Get.put(ConnectionsController());
    Get.put(PostController());
    Get.put(LikeController());
    Get.put(VehicleInfoController());
    Get.put(FirstOpenIsActiveRoute());
    Get.put(NotificationController());
    Get.put(MapPageMController());
  }
}

/*
import 'package:fillogo/controllers/berkay_controller/berkay_controller.dart';
import 'package:fillogo/controllers/bottom_navigation_bar_controller.dart';
import 'package:fillogo/controllers/chat/global_chat_controller.dart';
import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/controllers/future_controller.dart';
import 'package:fillogo/controllers/life_cycle/life_cycle_controller.dart';
import 'package:fillogo/controllers/map/first_login_is_active_route_controller.dart';
import 'package:fillogo/controllers/map/marker_icon_controller.dart';
import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/controllers/post_controller/posts_detail_controller.dart';
import 'package:fillogo/controllers/user/user_state_controller.dart';
import 'package:fillogo/controllers/vehicle_info_controller/vehicle_info_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/connection_view/components/connection_controller.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';
import 'package:fillogo/views/like_list_view/components/like_controller.dart';
import 'package:fillogo/views/map_page_new/map_pagem_controller.dart';
import 'package:fillogo/views/route_details_page_view/components/start_end_adress_controller.dart';
import '../../controllers/map/get_current_location_and_listen.dart';
import '../../views/map_page_view/components/map_page_controller.dart';
import '../../views/route_calculate_view/components/create_route_controller.dart';
import '../../views/route_details_page_view/components/selected_route_controller.dart';
import '../../widgets/google_maps_widgets/maps_general_widgets_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() async {
    Get.put(GetMyCurrentLocationController());
    Get.put(NotificationController());
    Get.put(SelectedRouteController());
    Get.put(ConnectionController());
    Get.put(BerkayController());
    Get.put(ConnectionsController());
    Get.put(BottomNavigationBarController());
    Get.put(GeneralDrawerController());
    Get.put(SetCustomMarkerIconController());
    Get.put(CreatePostPageController());

    Get.put(PostController());
    Get.put(LikeController());
    Get.put(UserStateController());
    Get.put(CreateRouteController());

    Get.put(MapPageController());
    Get.put(MapPageMController());

    Get.put(GoogleMapsGeneralWidgetsController());

    Get.put(StartEndAdressController());

    Get.put(LifeCycleController());
    Get.put(FutureController());
    Get.put(GlobalChatController());

    Get.put(VehicleInfoController());
    Get.put(FirstOpenIsActiveRoute());
  }
}

*/