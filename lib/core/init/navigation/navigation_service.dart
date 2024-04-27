import 'package:fillogo/bindings/chat/chat/chat_binding.dart';
import 'package:fillogo/bindings/chat/chat_message/chat_message_binding.dart';
//import 'package:fillogo/bindings/connections_binding/connections_binding.dart';
import 'package:fillogo/bindings/create_new_post_page/create_new_post_page_binding.dart';
import 'package:fillogo/bindings/dropdown_binding/dropdown_binding.dart';
import 'package:fillogo/bindings/media/media_picker_binding.dart';
import 'package:fillogo/bindings/search/search_user_binding.dart';
import 'package:fillogo/bindings/stepper/post_stepper_binding.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/views/abous_us_view/about_us_view.dart';
import 'package:fillogo/views/chat/chat_create_view/chat_create_view.dart';
import 'package:fillogo/views/chat/chat_message_view/chat_message_view.dart';
import 'package:fillogo/views/comments_view/comments_view.dart';
import 'package:fillogo/views/connection_view/connection_view.dart';
import 'package:fillogo/views/create_new_route_view/create_new_route_view.dart';
import 'package:fillogo/views/create_post_view/create_post_view.dart';
import 'package:fillogo/views/create_post_view/sub_pages_view/add_emotion.dart';
import 'package:fillogo/views/create_post_view/sub_pages_view/add_photo_and_video.dart';
import 'package:fillogo/views/create_post_view/sub_pages_view/add_route.dart';
import 'package:fillogo/views/create_post_view/sub_pages_view/add_user_tags_new_post.dart';
import 'package:fillogo/views/create_post_view/sub_pages_view/post_settings_page_view.dart';
import 'package:fillogo/views/find_similar_routes/find_similar_routes_page_view.dart';
import 'package:fillogo/views/forget_password/authentication_view/authentication_view.dart';
import 'package:fillogo/views/forget_password/forget_password_view.dart';
import 'package:fillogo/views/like_list_view/like_list_view.dart';
import 'package:fillogo/views/my_routes_view/my_routes_page_view.dart';
import 'package:fillogo/views/notifications_view/notifications_view.dart';
import 'package:fillogo/views/rotas_view/previous_rotas_view.dart';
import 'package:fillogo/views/rotas_view/rotas_view.dart';
import 'package:fillogo/views/route_details_page_view/route_details_page_view.dart';
import 'package:fillogo/views/search_user_view/search_user_view.dart';
import 'package:fillogo/views/settings/components/change_pass_view.dart';
import 'package:fillogo/views/settings/components/notification_settings_view.dart';
import 'package:fillogo/views/settings/components/preferences_settings_view.dart';
import 'package:fillogo/views/settings/components/profile_settings.dart';
import 'package:fillogo/views/settings/components/vehicle_settings.dart';
import 'package:fillogo/views/settings/settings_view.dart';
import 'package:fillogo/views/story_view/story_view.dart';
import 'package:fillogo/views/settings/components/report_view.dart';
import 'package:fillogo/views/story_view/add_story_view.dart';
import 'package:fillogo/views/welcome_login/components/route_login_or_register_widget.dart';
import 'package:fillogo/widgets/buttom_navigation_bar.dart';

import '../../../views/route_details_page_view/components/route_details_page_bindings.dart';
import '../../../views/route_details_page_view/components/selected_route_controller.dart';

class NavigationService {
  static List<GetPage> routes = [
    GetPage(
      name: NavigationConstants.onboardone,
      page: () => OnboardOneView(
        nextText: "İleri",
        centerText:
            "FilloGO ile beraber \n yola çıkan veya çıkacak olan\n arkadaşlarınızı görebilirsiniz. \n Gönderiler paylaşabilirsiniz.",
        nextTap: () {
          Get.offAndToNamed(NavigationConstants.onboardtwo);
        },
        skip: () => Get.offAndToNamed(NavigationConstants.onboardthree),
        imagePath: 'assets/images/2-1.png',
      ),
    ),
    GetPage(
      name: NavigationConstants.onboardtwo,
      page: () => OnboardOneView(
        nextText: "İleri",
        centerText:
            "Rotadaki arkadaşlarınızı\ngörebilir, onlarla iletişime geçebilirsiniz.\nGittiğiniz yerlerden paylaşım\nyapabilir,\nanılar oluşturabilirsiniz.",
        skip: () => Get.offAndToNamed(NavigationConstants.onboardthree),
        imagePath: 'assets/images/3-1.png',
        nextTap: () {
          Get.offAndToNamed(NavigationConstants.onboardthree);
        },
      ),
    ),
    GetPage(
      name: NavigationConstants.onboardthree,
      page: () => OnboardOneView(
        nextText: "Yolculuğa Başla",
        imagePath: 'assets/images/4-1.png',
        nextTap: () async {
          Get.offAndToNamed(NavigationConstants.welcomelogin);
        },
        centerText:
            "Şimdi bu maceranın\nbir parçası ol ve\nuygulamamıza katılarak\narkadaşlarınla ve diğer sürücülerle\nbağlantı kur.",
      ),
    ),
    GetPage(
      name: NavigationConstants.bottomNavigationBar,
      page: () => BottomNavigationBarView(),
    ),
    GetPage(
      name: NavigationConstants.routeLoginOrRegister,
      page: () => RouteLoginOrRegister(),
    ),
    GetPage(
      name: NavigationConstants.welcomelogin,
      page: () => WelcomeLoginView(),
    ),
    GetPage(
      name: NavigationConstants.register,
      page: () => RegisterView(),
    ),
    GetPage(
      name: NavigationConstants.login,
      page: () => LoginView(),
    ),
    GetPage(
      name: NavigationConstants.forgetPassword,
      page: () => ForgetPasswordView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.postflow,
      page: () => PostFlowView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.mapPage,
      page: () => MapPageView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.connectionView,
      page: () => ConnectionView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.message,
      binding: ChatBinding(),
      page: () => const ChatsView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.chatCreate,
      // binding: ChatBinding(),
      page: () => const ChatCreateView(),
    ),
    GetPage(
      transition: Transition.noTransition,
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.newroute,
      page: () => NewRouteView(),
      binding: PostStepperBinding(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.myprofil,
      page: () => const MyProfilView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.otherprofiles,
      page: () => OtherProfilsView(),
    ),
    GetPage(
      name: NavigationConstants.connectionError,
      page: () => ConnectionErrorView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.settings,
      page: () => SettingsView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.authentication,
      page: () => const AuthenticationView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.profileSettings,
      page: () => const ProfileSettings(),
      binding: DropdownBinding(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.notifications,
      page: () => NotificationsView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.aboutUs,
      page: () => const AboutUsView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.comments,
      page: () => const CommentsView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.likeListView,
      page: () => LikeListView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.vehicleSettings,
      page: () => const VehicleSettings(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.rotas,
      page: () => const RotasView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.routeDetails,
      page: () => RouteDetailsPageView(
        routeId: SelectedRouteController().selectedRouteId.value,
      ),
      binding: RouteDetailsPageBindings(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.previousRotas,
      page: () => const PreviousRotasView(),
    ),
    GetPage(
        transitionDuration: const Duration(milliseconds: 0),
        name: NavigationConstants.createPostPage,
        page: () => CreatePostPageView(),
        bindings: [
          MediaPickerBinding(),
          CreateNewPostPageBinding(),
        ]),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.createPostPageAddTags,
      page: () => CreatePostAddTagsPageView(),
      binding: CreateNewPostPageBinding(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.createPostPageAddEmotion,
      page: () => CreatePostAddEmotionPageView(),
      binding: CreateNewPostPageBinding(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.createPostPageAddRoute,
      page: () => CreatePostAddRoutePageView(),
      binding: CreateNewPostPageBinding(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.createPostPageAddPhoto,
      page: () => CreatePostAddPhotoAndVideoPageView(),
      binding: CreateNewPostPageBinding(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.createPostPageSettings,
      page: () => PostSettingsPageView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.storyPageView,
      page: () => const StoriesView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.chatDetailsView,
      page: () => ChatMessageView(),
      binding: ChatMessageBinding(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.searchUser,
      binding: SearchUserBinding(),
      page: () => SearchUserView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.createNewRouteView,
      page: () => const CreateNewRoutePageView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.myRoutesPageView,
      page: () => MyRoutesPageView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.findSimilarRoutesPageView,
      page: () => FindSimilarRoutesPageView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.changePassView,
      page: () => ChangePassView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.notificationSettingsView,
      page: () => NotificationSettingsView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.preferencesSettingsView,
      page: () => PreferencesSettingsView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.reportView,
      page: () => const ReportView(),
    ),
    GetPage(
      transitionDuration: const Duration(milliseconds: 0),
      name: NavigationConstants.addStory,
      page: () => const AddStoryView(),
    ),
    // GetPage(
    //   transitionDuration: const Duration(milliseconds: 0),
    //   name: NavigationConstants.locationServicesConfirm,
    //   page: () => const AddStoryView(),
    // ),
  ];
}
