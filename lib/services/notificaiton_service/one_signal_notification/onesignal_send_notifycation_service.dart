import 'dart:convert';
import 'package:fillogo/controllers/notification/notification_controller.dart';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/notification/notification_model.dart';
import 'package:http/http.dart' as http;

class OneSignalSenNotification {
  Future<void> sendNotification(
      {required NotificationModel notificationModel}) async {
    try {
      print(
          "NOTİFYCMM serv data type-> ${notificationModel.type} params -> ${notificationModel.params}");
      String apiKey = "NWRkNzg4YmQtMzQyOC00M2EyLTllNGItYTIzOTFlMzc5NmQ0";
      String appId = "ef065656-adab-4c84-b66e-245e0bdba8c6";

      final url = Uri.parse('https://onesignal.com/api/v1/notifications');

      final headers = {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Basic $apiKey',
      };

      final body = json.encode({
        "app_id": appId,
        // "included_segments": ["All"],
        "include_external_user_ids": [notificationModel.receiver.toString()],
        "data": notificationModel,
        "contents": {
          "en":
              "${notificationModel.message!.text!.username} ${notificationModel.message!.text!.surname} ${notificationModel.message!.text!.content}"
        },
        "priority": 10
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        print("NOTİFYCMM SERV otification sent successfully");
      } else {
        print("NOTİFYCMM SERV Failed to send notification: ${response.body}");
      }
    } catch (e) {
      print("NOTİFYCMM SERV ERRV -> $e");
    }
  }
}
