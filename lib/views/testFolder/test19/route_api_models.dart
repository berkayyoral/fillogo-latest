import 'dart:convert';

import '../../../export.dart';

class GetPollylineRequestModel {
  late OriginMyModel origin;
  late OriginMyModel destination;
  late String travelMode;
  late String routingPreference;
  //late String departureTime;
  late bool computeAlternativeRoutes;
  late RouteModifiersMyModel routeModifiers;
  late String languageCode;
  late String units;

  GetPollylineRequestModel({
    required this.origin,
    required this.destination,
    required this.travelMode,
    required this.routingPreference,
    //required this.departureTime,
    required this.computeAlternativeRoutes,
    required this.routeModifiers,
    required this.languageCode,
    required this.units,
  });

  GetPollylineRequestModel.fromJson(Map<String, dynamic> json) {
    origin = OriginMyModel.fromJson(json['origin']);
    destination = OriginMyModel.fromJson(json['destination']);
    travelMode = json['travelMode'];
    routingPreference = json['routingPreference'];
    //departureTime = json['departureTime'];
    computeAlternativeRoutes = json['computeAlternativeRoutes'];
    routeModifiers = RouteModifiersMyModel.fromJson(json['routeModifiers']);
    languageCode = json['languageCode'];
    units = json['units'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['origin'] = origin.toJson();
    data['destination'] = destination.toJson();
    data['travelMode'] = travelMode;
    data['routingPreference'] = routingPreference;
    //data['departureTime'] = departureTime;
    data['computeAlternativeRoutes'] = computeAlternativeRoutes;
    data['routeModifiers'] = routeModifiers.toJson();
    data['languageCode'] = languageCode;
    data['units'] = units;
    return data;
  }
}

class OriginMyModel {
  late LocationMyModel location;

  OriginMyModel({
    required this.location,
  });

  OriginMyModel.fromJson(Map<String, dynamic> json) {
    location = LocationMyModel.fromJson(json['location']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['location'] = location.toJson();
    return data;
  }
}

class LocationMyModel {
  late LatLngMyModel latLng;

  LocationMyModel({
    required this.latLng,
  });

  LocationMyModel.fromJson(Map<String, dynamic> json) {
    latLng = LatLngMyModel.fromJson(json['latLng']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latLng'] = latLng.toJson();
    return data;
  }
}

class LatLngMyModel {
  late double latitude;
  late double longitude;

  LatLngMyModel({
    required this.latitude,
    required this.longitude,
  });

  LatLngMyModel.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    return data;
  }
}

class RouteModifiersMyModel {
  late bool avoidTolls;
  late bool avoidHighways;
  late bool avoidFerries;

  RouteModifiersMyModel({
    required this.avoidTolls,
    required this.avoidHighways,
    required this.avoidFerries,
  });

  RouteModifiersMyModel.fromJson(Map<String, dynamic> json) {
    avoidTolls = json['avoidTolls'];
    avoidHighways = json['avoidHighways'];
    avoidFerries = json['avoidFerries'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avoidTolls'] = avoidTolls;
    data['avoidHighways'] = avoidHighways;
    data['avoidFerries'] = avoidFerries;
    return data;
  }
}

class GetPollylineResponseModel {
    GetPollylineResponseModel({
        this.routes,
    });

    List<RouteMyModel>? routes;

    factory GetPollylineResponseModel.fromRawJson(String str) => GetPollylineResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetPollylineResponseModel.fromJson(Map<String, dynamic> json) => GetPollylineResponseModel(
        routes: json["routes"] == null ? [] : List<RouteMyModel>.from(json["routes"]!.map((x) => RouteMyModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "routes": routes == null ? [] : List<dynamic>.from(routes!.map((x) => x.toJson())),
    };
}

class RouteMyModel {
    RouteMyModel({
        this.distanceMeters,
        this.duration,
        this.polyline,
    });

    int? distanceMeters;
    String? duration;
    PolylineMyModel? polyline;

    factory RouteMyModel.fromRawJson(String str) => RouteMyModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RouteMyModel.fromJson(Map<String, dynamic> json) => RouteMyModel(
        distanceMeters: json["distanceMeters"],
        duration: json["duration"],
        polyline: json["polyline"] == null ? null : PolylineMyModel.fromJson(json["polyline"]),
    );

    Map<String, dynamic> toJson() => {
        "distanceMeters": distanceMeters,
        "duration": duration,
        "polyline": polyline?.toJson(),
    };
}

class PolylineMyModel {
    PolylineMyModel({
        this.encodedPolyline,
    });

    String? encodedPolyline;

    factory PolylineMyModel.fromRawJson(String str) => PolylineMyModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PolylineMyModel.fromJson(Map<String, dynamic> json) => PolylineMyModel(
        encodedPolyline: json["encodedPolyline"],
    );

    Map<String, dynamic> toJson() => {
        "encodedPolyline": encodedPolyline,
    };
}

// class GetPollylineResponseModel {
//   List<RoutesMyModel>? routes;

//   GetPollylineResponseModel({this.routes});

//   GetPollylineResponseModel.fromJson(Map<String, dynamic> json) {
//     routes = <RoutesMyModel>[];
//     json['routes'].forEach((v) {
//       routes!.add(RoutesMyModel.fromJson(v));
//     });
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['routes'] = routes!.map((v) => v.toJson()).toList();
//     return data;
//   }
// }

// class RoutesMyModel {
//   late int distanceMeters;
//   late String duration;
//   late PolylineMyModel polyline;

//   RoutesMyModel({
//     required this.distanceMeters,
//     required this.duration,
//     required this.polyline,
//   });

//   RoutesMyModel.fromJson(Map<String, dynamic> json) {
//     distanceMeters = json['distanceMeters'];
//     duration = json['duration'];
//     polyline = PolylineMyModel.fromJson(json['polyline']);
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['distanceMeters'] = distanceMeters;
//     data['duration'] = duration;
//     data['polyline'] = polyline.toJson();
//     return data;
//   }
// }

// class PolylineMyModel {
//   late String encodedPolyline;

//   PolylineMyModel({required this.encodedPolyline});

//   PolylineMyModel.fromJson(Map<String, dynamic> json) {
//     encodedPolyline = json['encodedPolyline'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['encodedPolyline'] = encodedPolyline;
//     return data;
//   }
// }
