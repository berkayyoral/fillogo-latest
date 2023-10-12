import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/export.dart';
import 'package:fillogo/models/search/followers/search_followers_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/connection_view/components/connection_controller.dart';
import 'package:fillogo/widgets/custom_search_box.dart';
import 'package:fillogo/widgets/custom_user_information_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

// ignore: must_be_immutable
class FollowersView extends StatefulWidget {
  const FollowersView({super.key});

  @override
  State<FollowersView> createState() => _FollowersViewState();
}

class _FollowersViewState extends State<FollowersView> {
  final _numberOfPostsPerRequest = 10;

  final PagingController<int, FollowersResult> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    GeneralServicesTemp().makePostRequest(
      '/users/search-followers?page=1',
      connectionsController.searchFollowersRequest,
      {
        'Authorization':
            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
        'Content-Type': 'application/json',
      },
    ).then((value) {
      SearchFollowersResponse.fromJson(
        json.decode(value!),
      );
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      GeneralServicesTemp().makePostRequest(
        '/users/search-followers?page=$pageKey',
        connectionsController.searchFollowersRequest,
        {
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
          'Content-Type': 'application/json',
        },
      ).then((value) {
        var response = SearchFollowersResponse.fromJson(
          json.decode(value!),
        );
        final followersList = response.data![0].searchResult!.result;
        final isLastPage = followersList!.length < _numberOfPostsPerRequest;

        if (isLastPage) {
          _pagingController.appendLastPage(followersList);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(followersList, nextPageKey);
        }
      });
    } catch (e) {
      _pagingController.error = e;
    }
  }

  TextEditingController searchTextController = TextEditingController();

  ConnectionsController connectionsController = Get.find();

  @override
  Widget build(BuildContext context) {
    connectionsController.searchFollowersRequest.text = "";
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomSearchBox(
            controller: searchTextController,
            onChanged: (value) {
              connectionsController.searchRequestText =
                  searchTextController.text;

              connectionsController.searchFollowersRequest.text =
                  connectionsController.searchRequestText;
              connectionsController.update(['search']);

              GeneralServicesTemp()
                  .makePostRequest(
                    '/users/search-followers',
                    connectionsController.searchFollowersRequest,
                    ServicesConstants.appJsonWithToken,
                  )
                  .then(
                    (value) => SearchFollowersResponse.fromJson(
                      json.decode(value!),
                    ),
                  );
              Future.sync(() => _pagingController.refresh());
            },
          ),
          PagedListView<int, FollowersResult>(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<FollowersResult>(
              itemBuilder: (context, item, index) => UserInformationCard(
                imagePath: item.follower!.profilePicture!,
                name: item.follower!.name!,
                commonFollowers: "",
                onTap: () {
                  log("hey");
                },
                userId: item.follower!.id!,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
