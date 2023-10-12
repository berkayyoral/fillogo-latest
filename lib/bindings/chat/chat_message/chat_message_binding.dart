import 'package:fillogo/export.dart';
import 'package:fillogo/views/chat/chat_message_view/chat_message_controller.dart';

class ChatMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatMessageController());
  }
}
