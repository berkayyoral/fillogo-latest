import 'dart:convert';
import 'dart:developer';

import 'package:fillogo/export.dart';
import 'package:fillogo/models/search/following/search_following_response.dart';
import 'package:fillogo/services/general_sevices_template/general_services.dart';
import 'package:fillogo/views/connection_view/components/connection_controller.dart';
import 'package:fillogo/widgets/custom_search_box.dart';
import 'package:fillogo/widgets/custom_user_information_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class FollowingView extends StatefulWidget {
  const FollowingView({super.key});

  @override
  State<FollowingView> createState() => _FollowingViewState();
}

class _FollowingViewState extends State<FollowingView> {
  TextEditingController searchTextController = TextEditingController();

  ConnectionsController connectionsController = Get.find();
  final PagingController<int, FollowingResult> _pagingController =
      PagingController(firstPageKey: 1);
  final _numberOfPostsPerRequest = 10;

  @override
  void initState() {
    GeneralServicesTemp().makePostRequest(
      '/users/search-followings?page=1',
      connectionsController.searchFollowingRequest,
      {
        'Authorization':
            'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
        'Content-Type': 'application/json',
      },
    ).then((value) {
      SearchFollowingResponse.fromJson(
        json.decode(value!),
      );
    });
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      GeneralServicesTemp().makePostRequest(
        '/users/search-followings?page=$pageKey',
        connectionsController.searchFollowingRequest,
        {
          'Authorization':
              'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}',
          'Content-Type': 'application/json',
        },
      ).then((value) {
        var response = SearchFollowingResponse.fromJson(
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

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    connectionsController.searchFollowingRequest.text = "";
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          CustomSearchBox(
            controller: searchTextController,
            onChanged: (value) {
              connectionsController.searchRequestText =
                  searchTextController.text;

              connectionsController.searchFollowingRequest.text =
                  connectionsController.searchRequestText;
              connectionsController.update(['search']);

              GeneralServicesTemp()
                  .makePostRequest(
                    '/users/search-followings',
                    connectionsController.searchFollowingRequest,
                    ServicesConstants.appJsonWithToken,
                  )
                  .then(
                    (value) => SearchFollowingResponse.fromJson(
                      json.decode(value!),
                    ),
                  );
              Future.sync(() => _pagingController.refresh());
            },
          ),
          PagedListView<int, FollowingResult>(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate<FollowingResult>(
              itemBuilder: (context, item, index) => UserInformationCard(
                imagePath: item.profilePicture!,
                name: item.name!,
                commonFollowers: "",
                onTap: () {
                  Get.toNamed(NavigationConstants.otherprofiles,
                      arguments: item.id);
                },
                userId: item.id!,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget searchBox() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
      child: Container(
        width: 340.w,
        height: 50.h,
        decoration: BoxDecoration(
          color: AppConstants().ltWhite,
          borderRadius: BorderRadius.all(
            Radius.circular(
              8.r,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppConstants().ltLogoGrey.withOpacity(
                    0.2.r,
                  ),
              spreadRadius: 3,
              blurRadius: 3,
              offset: Offset(0.w, 0.w),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 296.w,
              height: 50.h,
              child: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: TextField(
                  onChanged: (value) {},
                  textAlignVertical: TextAlignVertical.center,
                  controller: searchTextController,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  cursorColor: AppConstants().ltMainRed,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: 'Sfregular',
                    color: AppConstants().ltLogoGrey,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8.r),
                      ),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Kullanıcı ara',
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontFamily: 'Sflight',
                      color: AppConstants().ltDarkGrey,
                    ),
                  ),
                ),
              ),
            ),
            FittedBox(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 10.w, right: 10.w, top: 13.h, bottom: 13.h),
                child: SvgPicture.asset(
                  height: 24.h,
                  width: 24.w,
                  'assets/icons/search-icon.svg',
                  color: AppConstants().ltLogoGrey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
