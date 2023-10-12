import 'dart:convert';

import 'package:fillogo/export.dart';

class PostService {
  Future<PostModel> postService(BuildContext context) async {
    final response = await DefaultAssetBundle.of(context)
        .loadString('assets/json/post.json');
    final data = await json.decode(response);
    return PostModel.fromJson(data);
  }
}
