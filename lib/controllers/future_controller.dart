import 'package:fillogo/export.dart';

class FutureController extends GetxController {
  void updatePagesByID(List<PageIDs> pageID) {
    update(pageID);
  }
}

enum PageIDs {
  myProfile,
}
