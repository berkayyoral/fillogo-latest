import 'package:fillogo/export.dart';

class GeneralDrawerController extends GetxController {
  final _isLoading = false.obs;
  get isLoading => _isLoading.value;
  set isLoading(value) {
    _isLoading.value = value;
    _isLoading.refresh();
  }

  GlobalKey<ScaffoldState> bottomnavBarKey = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> postFlowPageScaffoldKey = GlobalKey<ScaffoldState>();

  var mapPageScaffoldKey = GlobalKey<ScaffoldState>();
  var routeCalculatePageScaffoldKey = GlobalKey<ScaffoldState>();
  var myProfilePageScaffoldKey = GlobalKey<ScaffoldState>();
  var generalDrawerPageController = 0;

  void openPostFlowScaffoldDrawer() async {
    generalDrawerPageController = 1;
    postFlowPageScaffoldKey.currentState!.openDrawer();
  }

  void closePostFlowScaffoldDrawer() async {
    generalDrawerPageController = 0;
    postFlowPageScaffoldKey.currentState!.openEndDrawer();
  }

  void openMapPageScaffoldDrawer() async {
    generalDrawerPageController = 2;
    mapPageScaffoldKey.currentState!.openDrawer();
  }

  void closeMapPageScaffoldDrawer() async {
    generalDrawerPageController = 0;
    mapPageScaffoldKey.currentState!.openEndDrawer();
  }

  void openRouteCalculatePageScaffoldDrawer() async {
    generalDrawerPageController = 3;
    routeCalculatePageScaffoldKey.currentState!.openDrawer();
  }

  void closeRouteCalculatePageScaffoldDrawer() async {
    generalDrawerPageController = 0;
    routeCalculatePageScaffoldKey.currentState!.openEndDrawer();
  }

  void openMyProfilePageScaffoldDrawer() async {
    generalDrawerPageController = 4;
    myProfilePageScaffoldKey.currentState!.openDrawer();
  }

  void closeMyProfilePageScaffoldDrawer() async {
    generalDrawerPageController = 0;
    myProfilePageScaffoldKey.currentState!.openEndDrawer();
  }
}
