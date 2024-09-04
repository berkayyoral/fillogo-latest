import 'dart:io';

import 'package:fillogo/controllers/media/media_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/emoji/emoji_response_model.dart';
import 'package:fillogo/models/search/user/search_user_response.dart';

class CreatePostPageController extends GetxController {
  File? imageFile;

  RxBool isAddNewStory = false.obs;
  var selectedOption = EmotionData().obs;

  setSelectedOption(EmotionData option) {
    selectedOption.value = option;
    selectedOption.refresh;
  }

  var commentStatus = true.obs;
  var likedStatus = true.obs;
  var sharedStatus = false.obs;
  var secureStatus = true.obs;
  var addedStoryStatus = false.obs;
  var userPhoto = 'https://picsum.photos/150'.obs;
  var userName = 'Ahmet Pehlivan'.obs;
  var selectedEmotion = EmotionData().obs;
  var isSelectedEmotion = false.obs;
  var haveTag = 0.obs;
  var tagList = <UserResult>[].obs;
  var tagIdList = <int>[].obs;
  var haveDiscription = 0.obs;
  var discriptionContent = ''.obs;
  var haveRoute = 0.obs;
  var routeId = 0.obs;
  var routeContent = 'Samsun -> Ankara'.obs;
  var routeStartDate = '03.01.2023'.obs;
  var routeEndDate = '04.01.2023'.obs;
  var havePostPhoto = 0.obs;
  var postPhotoPath = 'https://picsum.photos/150'.obs;

  final RxString _searchRequestText = "".obs;
  String get searchRequestText => _searchRequestText.value;
  set searchRequestText(newValue) => _searchRequestText.value = newValue;

  void changeCommentStatus(bool newStatus) async {
    commentStatus.value = newStatus;
  }

  void changeSelectedEmotion(EmotionData newEmotion) async {
    selectedEmotion.value = newEmotion;
    selectedEmotion.refresh();
  }

  void changeDiscriptionContent(String discriptionContentNew) async {
    discriptionContent.value = discriptionContentNew;
  }

  void changeHavePostPhoto(int havePostPhotoNew) async {
    havePostPhoto.value = havePostPhotoNew;
  }

  void changePostPhotoPath(String postPhotoPathNew) async {
    postPhotoPath.value = postPhotoPathNew;
  }

  void changeRouteStartDate(String routeStartDateNew) async {
    routeStartDate.value = routeStartDateNew;
  }

  void changeRouteEndDate(String routeEndDateNew) async {
    routeEndDate.value = routeEndDateNew;
  }

  void changeHaveRoute(int haveRouteNew) async {
    haveRoute.value = haveRouteNew;
  }

  void changeRouteId(int newRouteId) async {
    routeId.value = newRouteId;
  }

  void changeRouteContent(String routeContentNew) async {
    routeContent.value = routeContentNew;
  }

  void changeHaveDiscription(int haveDiscriptionNew) async {
    haveDiscription.value = haveDiscriptionNew;
  }

  void changeUserPhoto(String userPhotoNew) async {
    userPhoto.value = userPhotoNew;
  }

  void changeUserName(String userNameNew) async {
    userName.value = userNameNew;
  }

  void changeTagList(UserResult newTagged) async {
    var newTagList = tagList.value;

    if (newTagList.contains(newTagged)) {
      newTagList.remove(newTagged);
    } else {
      newTagList.add(newTagged);
    }
    tagList.value = newTagList;
    tagList.refresh();
  }

  void changeTagIdList(int newTagged) async {
    var newTagList = tagIdList.value;

    if (newTagList.contains(newTagged)) {
      newTagList.remove(newTagged);
    } else {
      newTagList.add(newTagged);
    }
    tagIdList.value = newTagList;
    tagIdList.refresh();
  }

  void clearPostCreateInfoController() async {
    MediaPickerController mediaPickerController = Get.find();

    userPhoto.value = 'https://picsum.photos/150';
    userName.value = 'Ahmet Pehlivan';
    haveTag.value = 0;
    tagList.value = [];
    tagIdList.value = [];
    haveDiscription.value = 0;
    discriptionContent.value = '';
    haveRoute.value = 0;
    routeContent.value = 'Samsun -> Ankara';
    routeStartDate.value = '03.01.2023';
    routeEndDate.value = '04.01.2023';
    havePostPhoto.value = 0;
    postPhotoPath.value = 'https://picsum.photos/150';
    imageFile = File("");
    isSelectedEmotion.value = false;
    selectedEmotion.value = EmotionData();
    mediaPickerController.isMediaPicked = false;
  }

  // final _isVideo = false.obs;
  // get isVideo => _isVideo.value;
  // set isVideo(value) => _isVideo.value = value;

  // final _isMediaPicked = false.obs;
  // get isMediaPicked => _isMediaPicked.value;
  // set isMediaPicked(value) => _isMediaPicked.value = value;

  // final _isLoading = false.obs;
  // get isLoading => _isLoading.value;
  // set isLoading(value) => _isLoading.value = value;
}
