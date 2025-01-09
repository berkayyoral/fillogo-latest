import 'dart:convert';
import 'dart:developer';
import 'package:fillogo/export.dart';
import 'package:fillogo/models/user/set_new_token_model.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart' as parser;
import 'dart:io';
import 'package:file_picker/file_picker.dart';

class GeneralServicesTemp {
  final resultNotifier = ValueNotifier<RequestState>(RequestInitial());

  Future<String?> makePostRequest(String endPoint, Object? requestModel,
      Map<String, String>? postHeaders) async {
    final url = Uri.parse(AppConstants.baseURL + endPoint);
    resultNotifier.value = RequestLoadInProgress();
    final headers = postHeaders;
    final json = convert.json.encode(requestModel);
    final response = await post(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
    _handleResponse(response);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      return await makePatchRequest(
        EndPoint.setNewToken,
        SetNewTokenRequestModel(
          refreshToken:
              LocaleManager.instance.getString(PreferencesKeys.refreshToken),
        ),
        ServicesConstants.appJsonWithToken,
      ).then(
        (value) async {
          if (value != null) {
            final refreshResponse =
                SetNewTokenResponseModel.fromJson(jsonDecode(value));
            if (refreshResponse.success == 1) {
              LocaleManager.instance.setString(
                PreferencesKeys.accessToken,
                refreshResponse.data![0].tokens!.accessToken!,
              );
              LocaleManager.instance.setString(
                PreferencesKeys.refreshToken,
                refreshResponse.data![0].tokens!.refreshToken!,
              );
              if (postHeaders != null) {
                postHeaders
                    .removeWhere((key, value) => key.contains('Authorization'));
                postHeaders.addAll(
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                  },
                );
              }
              return await makePostRequest(
                endPoint,
                requestModel,
                postHeaders,
              ).then(
                (value) {
                  return value;
                },
              );
            }
          }
          return null;
        },
      );
    }
    return null;
  }

  Future<String?> makePostRequest2(
      String endPoint, Map<String, String>? postHeaders) async {
    final url = Uri.parse(AppConstants.baseURL + endPoint);
    resultNotifier.value = RequestLoadInProgress();
    final headers = postHeaders;
    final response = await post(url, headers: headers);
    // print('Status code: ${response.statusCode}');
    // print('Body: ${response.body}');
    _handleResponse(response);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      return await makePatchRequest(
        EndPoint.setNewToken,
        SetNewTokenRequestModel(
          refreshToken:
              LocaleManager.instance.getString(PreferencesKeys.refreshToken),
        ),
        ServicesConstants.appJsonWithToken,
      ).then(
        (value) async {
          if (value != null) {
            final refreshResponse =
                SetNewTokenResponseModel.fromJson(jsonDecode(value));
            if (refreshResponse.success == 1) {
              LocaleManager.instance.setString(
                PreferencesKeys.accessToken,
                refreshResponse.data![0].tokens!.accessToken!,
              );
              LocaleManager.instance.setString(
                PreferencesKeys.refreshToken,
                refreshResponse.data![0].tokens!.refreshToken!,
              );
              if (postHeaders != null) {
                postHeaders
                    .removeWhere((key, value) => key.contains('Authorization'));
                postHeaders.addAll(
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                  },
                );
              }
              return await makePostRequest2(endPoint, postHeaders).then(
                (value) {
                  return value;
                },
              );
            }
          }
          return null;
        },
      );
    }
    return null;
  }

  Future<String?> makePostRequestForPolyline(String endPoint,
      Object? requestModel, Map<String, String>? postHeaders) async {
    final url = Uri.parse(endPoint);
    resultNotifier.value = RequestLoadInProgress();
    final headers = postHeaders;
    final json = convert.json.encode(requestModel);
    try {
      final response = await post(url, headers: headers, body: json);
      // print('Status code: ${response.statusCode}');
      // print('Body: ${response.body}');
      _handleResponse(response);

      return response.body;
    } catch (e) {
      log("makePostRequestForPolyline ERROR: $e");
      return "makePostRequestForPolyline ERROR: $e";
    }
  }

  Future<String?> makePatchRequestWithFormData(
    String endPoint,
    Map<String, dynamic>? formData,
    Map<String, String>? postHeaders,
  ) async {
    final url = Uri.parse(AppConstants.baseURL + endPoint);
    resultNotifier.value = RequestLoadInProgress();
    final headers = postHeaders;
    var request = http.MultipartRequest('PATCH', url)..headers.addAll(headers!);
    formData!.forEach(
      (key, value) async {
        //if(value is File)
        request.fields[key] = value.toString();
        if (value is File) {
          //log("Dosya File 'a giriyor ${value.path.toString()}");
          request.files.add(
            await http.MultipartFile.fromPath(
              'file',
              value.path,
              contentType: parser.MediaType(
                'image',
                value.path.split('.').last,
              ),
            ),
          );
        }
      },
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      return responseBody;
    } else if (response.statusCode == 401) {
      return await makePatchRequest(
        EndPoint.setNewToken,
        SetNewTokenRequestModel(
          refreshToken:
              LocaleManager.instance.getString(PreferencesKeys.refreshToken),
        ),
        ServicesConstants.appJsonWithToken,
      ).then(
        (value) async {
          if (value != null) {
            final refreshResponse =
                SetNewTokenResponseModel.fromJson(jsonDecode(value));
            if (refreshResponse.success == 1) {
              LocaleManager.instance.setString(
                PreferencesKeys.accessToken,
                refreshResponse.data![0].tokens!.accessToken!,
              );
              LocaleManager.instance.setString(
                PreferencesKeys.refreshToken,
                refreshResponse.data![0].tokens!.refreshToken!,
              );
              if (postHeaders != null &&
                  postHeaders.containsKey('Authorization')) {
                postHeaders
                    .removeWhere((key, value) => key.contains('Authorization'));
                postHeaders.addAll(
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                  },
                );
              }
              return await makePatchRequestWithFormData(
                endPoint,
                formData,
                postHeaders,
              ).then(
                (value) {
                  return value;
                },
              );
            }
          }
          return null;
        },
      );
    } else {
      final responseBody = await response.stream.bytesToString();
      return responseBody;
    }
  }

  Future<String?> makePostRequestWithFormData(
    String endPoint,
    Map<String, dynamic>? formData,
    Map<String, String>? postHeaders,
  ) async {
    final url = Uri.parse(AppConstants.baseURL + endPoint);
    resultNotifier.value = RequestLoadInProgress();
    final headers = postHeaders;
    var request = http.MultipartRequest('POST', url)..headers.addAll(headers!);
    formData!.forEach((key, value) async {
      if (value is PlatformFile) {
        if (value.name.endsWith('.mp4')) {
          request.files.add(
            await http.MultipartFile.fromPath(
              'postMedia',
              value.path!,
              contentType: parser.MediaType(
                'video',
                value.path!.split('.').last,
              ),
            ),
          );
        } else {
          request.files.add(
            await http.MultipartFile.fromPath(
              'file',
              value.path!,
              contentType: parser.MediaType(
                'image',
                value.path!.split('.').last,
              ),
            ),
          );
        }
      } else {
        request.fields[key] = value.toString();
      }
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      log(responseBody.toString());
      return responseBody;
    } else if (response.statusCode == 401) {
      return await makePatchRequest(
        EndPoint.setNewToken,
        SetNewTokenRequestModel(
          refreshToken:
              LocaleManager.instance.getString(PreferencesKeys.refreshToken),
        ),
        ServicesConstants.appJsonWithToken,
      ).then(
        (value) async {
          if (value != null) {
            final refreshResponse =
                SetNewTokenResponseModel.fromJson(jsonDecode(value));
            if (refreshResponse.success == 1) {
              LocaleManager.instance.setString(
                PreferencesKeys.accessToken,
                refreshResponse.data![0].tokens!.accessToken!,
              );
              LocaleManager.instance.setString(
                PreferencesKeys.refreshToken,
                refreshResponse.data![0].tokens!.refreshToken!,
              );
              if (postHeaders != null &&
                  postHeaders.containsKey('Authorization')) {
                postHeaders
                    .removeWhere((key, value) => key.contains('Authorization'));
                postHeaders.addAll(
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                  },
                );
              }
              return await makePostRequestWithFormData(
                endPoint,
                formData,
                postHeaders,
              ).then(
                (value) {
                  //log(value.toString());
                  return value;
                },
              );
            }
          }
          return null;
        },
      );
    } else {
      final responseBody = await response.stream.bytesToString();
      //log(responseBody.toString());
      return responseBody;
    }
  }

  Future<String?> makeGetRequest(
      String endPoint, Map<String, String>? postHeaders) async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse(AppConstants.baseURL + endPoint);
    final headers = postHeaders;

    var response = await get(url, headers: headers);
    // print('Status code: ${response.statusCode}');
    // print('Body: ${response.body}');
    _handleResponse(response);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      return await makePatchRequest(
        EndPoint.setNewToken,
        SetNewTokenRequestModel(
          refreshToken:
              LocaleManager.instance.getString(PreferencesKeys.refreshToken),
        ),
        ServicesConstants.appJsonWithToken,
      ).then(
        (value) async {
          if (value != null) {
            final refreshResponse =
                SetNewTokenResponseModel.fromJson(jsonDecode(value));
            if (refreshResponse.success == 1) {
              LocaleManager.instance.setString(
                PreferencesKeys.accessToken,
                refreshResponse.data![0].tokens!.accessToken!,
              );
              LocaleManager.instance.setString(
                PreferencesKeys.refreshToken,
                refreshResponse.data![0].tokens!.refreshToken!,
              );
              if (postHeaders != null &&
                  postHeaders.containsKey('Authorization')) {
                postHeaders
                    .removeWhere((key, value) => key.contains('Authorization'));
                postHeaders.addAll(
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                  },
                );
              }
              return await makeGetRequest(
                endPoint,
                postHeaders,
              ).then(
                (value) {
                  //log(value.toString());
                  return value;
                },
              );
            }
          }
          return null;
        },
      );
    } else {
      return response.body;
    }
  }

  Future<String?> makePatchRequest(String endPoint, Object? requestModel,
      Map<String, String>? postHeaders) async {
    final url = Uri.parse(AppConstants.baseURL + endPoint);
    resultNotifier.value = RequestLoadInProgress();
    final headers = postHeaders;
    final json = convert.json.encode(requestModel);
    final response = await patch(url, headers: headers, body: json);
    // print('Status code: ${response.statusCode}');
    // print('Body: ${response.body}');
    _handleResponse(response);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      return await makePatchRequest(
        EndPoint.setNewToken,
        SetNewTokenRequestModel(
          refreshToken:
              LocaleManager.instance.getString(PreferencesKeys.refreshToken),
        ),
        ServicesConstants.appJsonWithToken,
      ).then(
        (value) async {
          if (value != null) {
            final refreshResponse =
                SetNewTokenResponseModel.fromJson(jsonDecode(value));
            if (refreshResponse.success == 1) {
              LocaleManager.instance.setString(
                PreferencesKeys.accessToken,
                refreshResponse.data![0].tokens!.accessToken!,
              );
              LocaleManager.instance.setString(
                PreferencesKeys.refreshToken,
                refreshResponse.data![0].tokens!.refreshToken!,
              );
              if (postHeaders != null &&
                  postHeaders.containsKey('Authorization')) {
                postHeaders
                    .removeWhere((key, value) => key.contains('Authorization'));
                postHeaders.addAll(
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                  },
                );
              }
              return await makePatchRequest(
                endPoint,
                requestModel,
                postHeaders,
              ).then(
                (value) {
                  //log(value.toString());
                  return value;
                },
              );
            }
          }
          return null;
        },
      );
    } else {
      return response.body;
    }
  }

  Future<String?> makeDeleteRequest(String endPoint, Object? requestModel,
      Map<String, String>? postHeaders) async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse(AppConstants.baseURL + endPoint);
    final headers = postHeaders;
    final json = convert.json.encode(requestModel);
    final response = await delete(url, headers: headers, body: json);
    // print('Status code: ${response.statusCode}');
    // print('Body: ${response.body}');
    _handleResponse(response);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      return await makePatchRequest(
        EndPoint.setNewToken,
        SetNewTokenRequestModel(
          refreshToken:
              LocaleManager.instance.getString(PreferencesKeys.refreshToken),
        ),
        ServicesConstants.appJsonWithToken,
      ).then(
        (value) async {
          if (value != null) {
            final refreshResponse =
                SetNewTokenResponseModel.fromJson(jsonDecode(value));
            if (refreshResponse.success == 1) {
              LocaleManager.instance.setString(
                PreferencesKeys.accessToken,
                refreshResponse.data![0].tokens!.accessToken!,
              );
              LocaleManager.instance.setString(
                PreferencesKeys.refreshToken,
                refreshResponse.data![0].tokens!.refreshToken!,
              );
              if (postHeaders != null &&
                  postHeaders.containsKey('Authorization')) {
                postHeaders
                    .removeWhere((key, value) => key.contains('Authorization'));
                postHeaders.addAll(
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                  },
                );
              }
              return await makeDeleteRequest(
                endPoint,
                requestModel,
                postHeaders,
              ).then(
                (value) {
                  //log(value.toString());
                  return value;
                },
              );
            }
          }
          return null;
        },
      );
    }
    return null;
  }

  Future<String?> makeDeleteWithoutBody(
      String endPoint, Map<String, String>? postHeaders) async {
    resultNotifier.value = RequestLoadInProgress();
    final url = Uri.parse(AppConstants.baseURL + endPoint);
    final headers = postHeaders;

    final response = await delete(url, headers: headers);
    // print('Status code: ${response.statusCode}');
    // print('Body: ${response.body}');
    _handleResponse(response);
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 401) {
      return await makePatchRequest(
        EndPoint.setNewToken,
        SetNewTokenRequestModel(
          refreshToken:
              LocaleManager.instance.getString(PreferencesKeys.refreshToken),
        ),
        ServicesConstants.appJsonWithToken,
      ).then(
        (value) async {
          if (value != null) {
            final refreshResponse =
                SetNewTokenResponseModel.fromJson(jsonDecode(value));
            if (refreshResponse.success == 1) {
              LocaleManager.instance.setString(
                PreferencesKeys.accessToken,
                refreshResponse.data![0].tokens!.accessToken!,
              );
              LocaleManager.instance.setString(
                PreferencesKeys.refreshToken,
                refreshResponse.data![0].tokens!.refreshToken!,
              );
              if (postHeaders != null &&
                  postHeaders.containsKey('Authorization')) {
                postHeaders
                    .removeWhere((key, value) => key.contains('Authorization'));
                postHeaders.addAll(
                  {
                    'Authorization':
                        'Bearer ${LocaleManager.instance.getString(PreferencesKeys.accessToken)}'
                  },
                );
              }
              return await makeDeleteWithoutBody(
                endPoint,
                postHeaders,
              ).then(
                (value) {
                  //log(value.toString());
                  return value;
                },
              );
            }
          }
          return null;
        },
      );
    }
    return null;
  }

  void _handleResponse(var response) {
    if (response.statusCode >= 400) {
      resultNotifier.value = RequestLoadFailure();
    } else {
      resultNotifier.value = RequestLoadSuccess(response.body);
    }
  }
}

class RequestState {
  const RequestState();
}

class RequestInitial extends RequestState {}

class RequestLoadInProgress extends RequestState {}

class RequestLoadSuccess extends RequestState {
  const RequestLoadSuccess(this.body);
  final String body;
}

class RequestLoadFailure extends RequestState {}
