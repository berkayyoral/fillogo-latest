import 'package:fillogo/export.dart';
import 'package:fillogo/views/map_page_new/controller/map_pagem_controller.dart';

class MatchingRoutesButton extends StatelessWidget {
  final bool isMatchingRoute;

  const MatchingRoutesButton({
    super.key,
    required this.isMatchingRoute,
  });

  @override
  Widget build(BuildContext context) {
    final MapPageMController mapPageMController = Get.find();
    return Obx(
      () => Visibility(
        visible: mapPageMController.isThereActiveRoute.value,
        child: Positioned(
          bottom: !isMatchingRoute
              ? 10.h
              : mapPageMController.finishRouteButton.value
                  ? 180.h
                  : 120.h,
          right: 10.w,
          child: InkWell(
            onTap: () async {
              mapPageMController.isOpenMatchingRoutesWidget.value =
                  isMatchingRoute;
              if (mapPageMController.isOpenMatchingRoutesWidget.value) {
                await mapPageMController.getMatchingRoutes(
                    routePolylineCode:
                        mapPageMController.myActiveRoutePolylineCode);
              }
            },
            child: Container(
              height: 50.w,
              width: 50.w,
              decoration: BoxDecoration(
                color: AppConstants().ltWhiteGrey,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: SvgPicture.asset(
                  "assets/icons/map-page-list-icon-kesisen.svg",
                  height: 24.w,
                  color: AppConstants().ltMainRed,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
