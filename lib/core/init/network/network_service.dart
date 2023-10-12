import 'dart:convert';

import 'package:http/http.dart' as https;

import '../../../export.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._init();
  static NetworkService get instance => _instance;

  NetworkService._init();

  Future<dynamic> http<T extends IBaseModel>(
    String path,
    IBaseModel model,
    Methods method, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    var url = Uri.https(AppConstants.baseURL, path, queryParameters);
    //LocaleManager.instance.setString(PreferencesKeys.accessToken, ''); TODO Giriş yapıldığında token cihaza kaydedilcek
    String accessToken =
        LocaleManager.instance.getString(PreferencesKeys.accessToken) ?? '';

    var headers = {
      'content-type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    https.Response? response;

    switch (method) {
      case Methods.get:
        response = await https.get(url, headers: headers).timeout(
              const Duration(seconds: AppConstants.responseTimeout),
              onTimeout: () => https.Response('Timeout', 408),
            );
        break;
      case Methods.post:
        response = await https
            .post(url, headers: headers, body: jsonEncode(body))
            .timeout(
              const Duration(seconds: AppConstants.responseTimeout),
              onTimeout: () => https.Response('Timeout', 408),
            );
        break;
      case Methods.put:
        response = await https
            .put(url, headers: headers, body: jsonEncode(body))
            .timeout(
              const Duration(seconds: AppConstants.responseTimeout),
              onTimeout: () => https.Response('Timeout', 408),
            );
        break;
      case Methods.delete:
        response = await https
            .put(url, headers: headers, body: jsonEncode(body))
            .timeout(
              const Duration(seconds: AppConstants.responseTimeout),
              onTimeout: () => https.Response('Timeout', 408),
            );
        break;
      default:
    }

    if (response!.statusCode == 200) {
      return jsonBodyParser<T>(model, response.body);
    } else if (response.statusCode == 401) {
      // TODO logout ve token' ı sil
    } else if (response.statusCode == 408) {
      return Get.offAndToNamed(NavigationConstants.connectionError);
    } else {
      // Hata mesajını ekrana göster Get.Snackbar()
      return jsonBodyParser<T>(model, response.body);
    }
  }

  dynamic jsonBodyParser<T>(IBaseModel model, String body) {
    final Map<String, dynamic> jsonBody = jsonDecode(body);
    return model.fromJson(jsonBody);
  }
}
