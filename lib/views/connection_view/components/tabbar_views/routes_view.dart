import 'dart:convert';

import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/search_user_routes.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/connection_view/components/connection_controller.dart';
import 'package:fillogo/views/search_user_view/components/search_profile_card.dart';

class RoutesView extends StatelessWidget {
  RoutesView({super.key});

  final ConnectionsController connectionsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder<SearchUserRoutesResponse>(
            future: GeneralServicesTemp().makePostRequest(
                EndPoint.searchUserRoutes,
                SearchUserRoutesRequest(
                    startingCity: "",
                    endingCity: "",
                    userId: connectionsController.user.id),
                {
                  "Content-type": "application/json",
                  'Authorization':
                      'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                }).then((value) {
              return SearchUserRoutesResponse.fromJson(jsonDecode(value!));
            }),
            builder: (context, snapshot) {
              print(snapshot.data!.data![0].active);
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.data![0].active!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return SearchProfileCard(
                      allRoute: snapshot.data!.data![0].active!.length,
                      name:
                          "${snapshot.data!.data![0].active![index].user!.name!} ${snapshot.data!.data![0].active![index].user!.surname!}",
                      nickName:
                          snapshot.data!.data![0].active![index].user!.name!,
                    );
                  },
                );
              } else {
                return CircularProgressIndicator();
              }
            })
      ],
    );
  }
}
