import 'package:fillogo/export.dart';
import 'package:fillogo/services/socket/socket_service.dart';

class UserStateController extends GetxController {
  @override
  void onInit() {
    getUsersInSocket();
    super.onInit();
  }

  final _onlineUserList = [].obs;
  get onlineUserList => _onlineUserList;
  set onlineUserList(newList) {
    _onlineUserList.clear();
    _onlineUserList.value = newList;
    _onlineUserList.refresh();
  }

  void getUsersInSocket() {
    SocketService.instance().socket.on('get-users', (data) async {
      if (data != null) {
        onlineUserList = data;
        Logger().d(onlineUserList);
        UserStateController().update(["onlineUsers"]);
      }
    });
  }

  bool isUserOnline({required int userId}) {
    List<int> onlineUserIdList = [];
    for (var element in _onlineUserList) {
      onlineUserIdList.add(element['userId']);
    }
    if (onlineUserIdList.contains(userId)) {
      return true;
    } else {
      return false;
    }
  }
}
