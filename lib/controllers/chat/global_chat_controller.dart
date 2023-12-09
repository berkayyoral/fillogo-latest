import '../../export.dart';

class GlobalChatController extends GetxController {
  final _messageSeen = "".obs;
  get messageSeen => _messageSeen.value;
  set messageSeen(newValue) => _messageSeen.value = newValue;

  final _messageSeenChatId = 0.obs;
  get messageSeenChatId => _messageSeenChatId.value;
  set messageSeenChatId(newValue) => _messageSeenChatId.value = newValue;

  final _isMessageView = false.obs;
  get isMessageView => _isMessageView.value;
  set isMessageView(newValue) => _isMessageView.value = newValue;

}
