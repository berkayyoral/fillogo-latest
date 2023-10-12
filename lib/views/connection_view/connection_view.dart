import 'package:fillogo/export.dart';
import 'package:fillogo/views/connection_view/components/connection_controller.dart';
import 'package:fillogo/views/connection_view/components/tabbar_views/followers_view.dart';
import 'package:fillogo/views/connection_view/components/tabbar_views/following_view.dart';
import 'package:fillogo/views/connection_view/components/tabbar_views/routes_view.dart';

import 'package:fillogo/widgets/custom_tabbar.dart';

// ignore: must_be_immutable
class ConnectionView extends StatelessWidget {
  ConnectionView({super.key});
  ConnectionsController connectionsController = Get.find();

  @override
  Widget build(BuildContext context) {
    ConnectionsController connectionsController = Get.find();

    return Scaffold(
      appBar: buildAppbar(connectionsController),
      body: Column(
        children: [
          CustomTabBar(
            tabBarList: tabBarList(),
            tabBarViewList: tabBarViewList,
          )
        ],
      ),
    );
  }

  List<Tab> tabBarList() {
    return [
      Tab(child: Text("${connectionsController.followerCount} Takipçi")),
      Tab(child: Text("${connectionsController.followingCount} Takip Edilen")),
      Tab(child: Text("${connectionsController.routeCount}  Rotalar")),
    ];
  }

  final List<Widget> tabBarViewList = [
    FollowersView(),
    FollowingView(),
    RoutesView(),
  ];

  AppBarGenel buildAppbar(ConnectionsController connectionsController) {
    return AppBarGenel(
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.w,
          ),
          child: SvgPicture.asset(
            height: 24.h,
            width: 24.w,
            'assets/icons/back-icon.svg',
            color: AppConstants().ltLogoGrey,
          ),
        ),
      ),
      title: Text(
        "${connectionsController.user.name!} ${connectionsController.user.surname!}",
        style: TextStyle(
          fontFamily: "Sfbold",
          fontSize: 20.sp,
          color: AppConstants().ltBlack,
        ),
      ),
    );
  }
}
