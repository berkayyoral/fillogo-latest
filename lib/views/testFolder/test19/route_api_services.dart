import 'package:fillogo/views/testFolder/test19/route_api_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var url2 =
    Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
var url = Uri.https('routes.googleapis.com/directions/v2:computeRoutes', '');
GetPollylineResponseModel routeResponseModel = GetPollylineResponseModel();

class GetPollylineRequest {
  void getPollylineRequest(
    GetPollylineRequestModel requestModel,
  ) async {
    print("MAPTENPOLYLİNECODU ALDIM");
    var response = await http.post(
      url,
      body: requestModel,
      headers: {
        'Content-Type': 'application/json',
        'X-Goog-Api-Key': 'AIzaSyAFFLTo2huCvR-HiQTkDIpjJ5Yb-b-erN8',
        'X-Goog-FieldMask':
            'routes.duration,routes.distanceMeters,routes.polyline.encodedPolyline',
      },
    );
    //print("AAAAAAAAA: ${response.body}");
    var data = await json.decode(response.body);
    //print("AAAAAAAAA: ${data.toString()}");
  }
}
