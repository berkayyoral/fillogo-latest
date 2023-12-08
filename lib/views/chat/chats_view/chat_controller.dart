
import 'package:fillogo/controllers/chat/global_chat_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/chat/chats/chat_response_model.dart';
import 'package:fillogo/models/search/following/search_following_request.dart';
import 'package:fillogo/services/socket/socket_service.dart';

class ChatController extends GetxController {
  var receiverId = 0.obs;

  final _chatList = [].obs;
  get chatList => _chatList;
  set chatList(newValue) {
    _chatList.clear();
    _chatList.value = newValue;
    _chatList.refresh();
  }

  final RxInt _chatId = 0.obs;
  int get chatId => _chatId.value;
  set chatId(newValue) => _chatId.value = newValue;

  final _receiverUser = SenderClass().obs;
  SenderClass get receiverUser => _receiverUser.value;
  set receiverUser(newValue) => _receiverUser.value = newValue;

  final RxString _searchRequestText = "".obs;
  String get searchRequestText => _searchRequestText.value;
  set searchRequestText(newValue) => _searchRequestText.value = newValue;

  var liveChattingUserId = 0.obs;

  changeLiveChattingUserId(newValue) {
    liveChattingUserId.value = newValue;
    liveChattingUserId.refresh();
  }

  clearLiveChattingUserId() {
    liveChattingUserId.value = 0;
  }

  SearchFollowingRequest searchFollowingRequest = SearchFollowingRequest();

  @override
  void onInit() {
    messageSeenListenInSocket();
    super.onInit();
  }

  void messageSeenListenInSocket() {
    GlobalChatController globalChatController = Get.find();
    SocketService.instance().socket.on('message-seen', (data) async {
      if (data['chatId'] == chatId) {
        globalChatController.messageSeen = data['status'];
        globalChatController.messageSeenChatId = data['chatId'];
      }
    });
  }

  @override
  void onClose() {
    //log("onClose");
    super.onClose();
  }
}
