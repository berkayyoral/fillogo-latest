import 'package:fillogo/export.dart';
import 'package:fillogo/views/chat/chats_view/chat_controller.dart';

class ChatBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
  }
}
