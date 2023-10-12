import 'dart:convert';

class RouteCalculateRequestModel {
  RouteCalculateRequestModel({
    this.origin,
    this.destination,
    this.intermediates,
    this.travelMode,
    this.routingPreference,
    this.polylineQuality,
    this.polylineEncoding,
    this.departureTime,
    this.computeAlternativeRoutes,
    this.languageCode,
    this.routeModifiers,
    this.regionCode,
    this.units,
    this.requestedReferenceRoutes,
    this.extraComputations,
  });

  Destination? origin;
  Destination? destination;
  List<Intermediate>? intermediates;
  String? travelMode;
  String? routingPreference;
  String? polylineQuality;
  String? polylineEncoding;
  DateTime? departureTime;
  bool? computeAlternativeRoutes;
  String? languageCode;
  RouteModifiers? routeModifiers;
  String? regionCode;
  String? units;
  List<String>? requestedReferenceRoutes;
  List<String>? extraComputations;

  factory RouteCalculateRequestModel.fromRawJson(String str) =>
      RouteCalculateRequestModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RouteCalculateRequestModel.fromJson(Map<String, dynamic> json) =>
      RouteCalculateRequestModel(
        origin: json["origin"] == null
            ? null
            : Destination.fromJson(json["origin"]),
        destination: json["destination"] == null
            ? null
            : Destination.fromJson(json["destination"]),
        intermediates: json["intermediates"] == null
            ? []
            : List<Intermediate>.from(
                json["intermediates"]!.map((x) => Intermediate.fromJson(x))),
        travelMode: json["travelMode"],
        routingPreference: json["routingPreference"],
        polylineQuality: json["polylineQuality"],
        polylineEncoding: json["polylineEncoding"],
        departureTime: json["departureTime"] == null
            ? null
            : DateTime.parse(json["departureTime"]),
        computeAlternativeRoutes: json["computeAlternativeRoutes"],
        languageCode: json["languageCode"],
        routeModifiers: json["routeModifiers"] == null
            ? null
            : RouteModifiers.fromJson(json["routeModifiers"]),
        regionCode: json["regionCode"],
        units: json["units"],
        requestedReferenceRoutes: json["requestedReferenceRoutes"] == null
            ? []
            : List<String>.from(
                json["requestedReferenceRoutes"]!.map((x) => x)),
        extraComputations: json["extraComputations"] == null
            ? []
            : List<String>.from(json["extraComputations"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "origin": origin?.toJson(),
        "destination": destination?.toJson(),
        "intermediates": intermediates == null
            ? []
            : List<dynamic>.from(intermediates!.map((x) => x.toJson())),
        "travelMode": travelMode,
        "routingPreference": routingPreference,
        "polylineQuality": polylineQuality,
        "polylineEncoding": polylineEncoding,
        "departureTime": departureTime?.toIso8601String(),
        "computeAlternativeRoutes": computeAlternativeRoutes,
        "languageCode": languageCode,
        "routeModifiers": routeModifiers?.toJson(),
        "regionCode": regionCode,
        "units": units,
        "requestedReferenceRoutes": requestedReferenceRoutes == null
            ? []
            : List<dynamic>.from(requestedReferenceRoutes!.map((x) => x)),
        "extraComputations": extraComputations == null
            ? []
            : List<dynamic>.from(extraComputations!.map((x) => x)),
      };
}

class Destinations {
  Destinations({
    this.location,
  });

  Intermediate? location;

  factory Destinations.fromRawJson(String str) =>
      Destinations.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Destinations.fromJson(Map<String, dynamic> json) => Destinations(
        location: json["location"] == null
            ? null
            : Intermediate.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location?.toJson(),
      };
}

class Intermediate {
  Intermediate({
    this.latLng,
  });

  LatLng? latLng;

  factory Intermediate.fromRawJson(String str) =>
      Intermediate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Intermediate.fromJson(Map<String, dynamic> json) => Intermediate(
        latLng: json["latLng"] == null ? null : LatLng.fromJson(json["latLng"]),
      );

  Map<String, dynamic> toJson() => {
        "latLng": latLng?.toJson(),
      };
}

class LatLng {
  LatLng({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory LatLng.fromRawJson(String str) => LatLng.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LatLng.fromJson(Map<String, dynamic> json) => LatLng(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class RouteModifiers {
  RouteModifiers({
    this.avoidTolls,
    this.avoidHighways,
    this.avoidFerries,
    this.avoidIndoor,
    this.vehicleInfo,
    this.tollPasses,
  });

  bool? avoidTolls;
  bool? avoidHighways;
  bool? avoidFerries;
  bool? avoidIndoor;
  VehicleInfo? vehicleInfo;
  List<String>? tollPasses;

  factory RouteModifiers.fromRawJson(String str) =>
      RouteModifiers.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RouteModifiers.fromJson(Map<String, dynamic> json) => RouteModifiers(
        avoidTolls: json["avoidTolls"],
        avoidHighways: json["avoidHighways"],
        avoidFerries: json["avoidFerries"],
        avoidIndoor: json["avoidIndoor"],
        vehicleInfo: json["vehicleInfo"] == null
            ? null
            : VehicleInfo.fromJson(json["vehicleInfo"]),
        tollPasses: json["tollPasses"] == null
            ? []
            : List<String>.from(json["tollPasses"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "avoidTolls": avoidTolls,
        "avoidHighways": avoidHighways,
        "avoidFerries": avoidFerries,
        "avoidIndoor": avoidIndoor,
        "vehicleInfo": vehicleInfo?.toJson(),
        "tollPasses": tollPasses == null
            ? []
            : List<dynamic>.from(tollPasses!.map((x) => x)),
      };
}

class VehicleInfo {
  VehicleInfo({
    this.emissionType,
  });

  String? emissionType;

  factory VehicleInfo.fromRawJson(String str) =>
      VehicleInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VehicleInfo.fromJson(Map<String, dynamic> json) => VehicleInfo(
        emissionType: json["emissionType"],
      );

  Map<String, dynamic> toJson() => {
        "emissionType": emissionType,
      };
}

//
//
//
//
//

class RouteCalculateResponseModel {
  RouteCalculateResponseModel({
    this.routes,
    this.fallbackInfo,
    this.geocodingResults,
  });

  List<Route>? routes;
  FallbackInfo? fallbackInfo;
  GeocodingResults? geocodingResults;

  factory RouteCalculateResponseModel.fromRawJson(String str) =>
      RouteCalculateResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RouteCalculateResponseModel.fromJson(Map<String, dynamic> json) =>
      RouteCalculateResponseModel(
        routes: json["routes"] == null
            ? []
            : List<Route>.from(json["routes"]!.map((x) => Route.fromJson(x))),
        fallbackInfo: json["fallbackInfo"] == null
            ? null
            : FallbackInfo.fromJson(json["fallbackInfo"]),
        geocodingResults: json["geocodingResults"] == null
            ? null
            : GeocodingResults.fromJson(json["geocodingResults"]),
      );

  Map<String, dynamic> toJson() => {
        "routes": routes == null
            ? []
            : List<dynamic>.from(routes!.map((x) => x.toJson())),
        "fallbackInfo": fallbackInfo?.toJson(),
        "geocodingResults": geocodingResults?.toJson(),
      };
}

class FallbackInfo {
  FallbackInfo({
    this.routingMode,
    this.reason,
  });

  String? routingMode;
  String? reason;

  factory FallbackInfo.fromRawJson(String str) =>
      FallbackInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FallbackInfo.fromJson(Map<String, dynamic> json) => FallbackInfo(
        routingMode: json["routingMode"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "routingMode": routingMode,
        "reason": reason,
      };
}

class GeocodingResults {
  GeocodingResults({
    this.origin,
    this.destination,
    this.intermediates,
  });

  Destination? origin;
  Destination? destination;
  List<Destination>? intermediates;

  factory GeocodingResults.fromRawJson(String str) =>
      GeocodingResults.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeocodingResults.fromJson(Map<String, dynamic> json) =>
      GeocodingResults(
        origin: json["origin"] == null
            ? null
            : Destination.fromJson(json["origin"]),
        destination: json["destination"] == null
            ? null
            : Destination.fromJson(json["destination"]),
        intermediates: json["intermediates"] == null
            ? []
            : List<Destination>.from(
                json["intermediates"]!.map((x) => Destination.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "origin": origin?.toJson(),
        "destination": destination?.toJson(),
        "intermediates": intermediates == null
            ? []
            : List<dynamic>.from(intermediates!.map((x) => x.toJson())),
      };
}

class Destination {
  Destination({
    this.geocoderStatus,
    this.type,
    this.partialMatch,
    this.placeId,
    this.intermediateWaypointRequestIndex,
  });

  GeocoderStatus? geocoderStatus;
  List<String>? type;
  bool? partialMatch;
  String? placeId;
  int? intermediateWaypointRequestIndex;

  factory Destination.fromRawJson(String str) =>
      Destination.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Destination.fromJson(Map<String, dynamic> json) => Destination(
        geocoderStatus: json["geocoderStatus"] == null
            ? null
            : GeocoderStatus.fromJson(json["geocoderStatus"]),
        type: json["type"] == null
            ? []
            : List<String>.from(json["type"]!.map((x) => x)),
        partialMatch: json["partialMatch"],
        placeId: json["placeId"],
        intermediateWaypointRequestIndex:
            json["intermediateWaypointRequestIndex"],
      );

  Map<String, dynamic> toJson() => {
        "geocoderStatus": geocoderStatus?.toJson(),
        "type": type == null ? [] : List<dynamic>.from(type!.map((x) => x)),
        "partialMatch": partialMatch,
        "placeId": placeId,
        "intermediateWaypointRequestIndex": intermediateWaypointRequestIndex,
      };
}

class GeocoderStatus {
  GeocoderStatus({
    this.code,
    this.message,
    this.details,
  });

  int? code;
  String? message;
  List<Detail>? details;

  factory GeocoderStatus.fromRawJson(String str) =>
      GeocoderStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GeocoderStatus.fromJson(Map<String, dynamic> json) => GeocoderStatus(
        code: json["code"],
        message: json["message"],
        details: json["details"] == null
            ? []
            : List<Detail>.from(
                json["details"]!.map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "details": details == null
            ? []
            : List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.type,
  });

  String? type;

  factory Detail.fromRawJson(String str) => Detail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        type: json["@type"],
      );

  Map<String, dynamic> toJson() => {
        "@type": type,
      };
}

class Route {
  Route({
    this.routeLabels,
    this.legs,
    this.distanceMeters,
    this.duration,
    this.staticDuration,
    this.polyline,
    this.description,
    this.warnings,
    this.viewport,
    this.travelAdvisory,
    this.routeToken,
  });

  List<String>? routeLabels;
  List<Leg>? legs;
  int? distanceMeters;
  String? duration;
  String? staticDuration;
  Polyline? polyline;
  String? description;
  List<String>? warnings;
  Viewport? viewport;
  LegTravelAdvisory? travelAdvisory;
  String? routeToken;

  factory Route.fromRawJson(String str) => Route.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        routeLabels: json["routeLabels"] == null
            ? []
            : List<String>.from(json["routeLabels"]!.map((x) => x)),
        legs: json["legs"] == null
            ? []
            : List<Leg>.from(json["legs"]!.map((x) => Leg.fromJson(x))),
        distanceMeters: json["distanceMeters"],
        duration: json["duration"],
        staticDuration: json["staticDuration"],
        polyline: json["polyline"] == null
            ? null
            : Polyline.fromJson(json["polyline"]),
        description: json["description"],
        warnings: json["warnings"] == null
            ? []
            : List<String>.from(json["warnings"]!.map((x) => x)),
        viewport: json["viewport"] == null
            ? null
            : Viewport.fromJson(json["viewport"]),
        travelAdvisory: json["travelAdvisory"] == null
            ? null
            : LegTravelAdvisory.fromJson(json["travelAdvisory"]),
        routeToken: json["routeToken"],
      );

  Map<String, dynamic> toJson() => {
        "routeLabels": routeLabels == null
            ? []
            : List<dynamic>.from(routeLabels!.map((x) => x)),
        "legs": legs == null
            ? []
            : List<dynamic>.from(legs!.map((x) => x.toJson())),
        "distanceMeters": distanceMeters,
        "duration": duration,
        "staticDuration": staticDuration,
        "polyline": polyline?.toJson(),
        "description": description,
        "warnings":
            warnings == null ? [] : List<dynamic>.from(warnings!.map((x) => x)),
        "viewport": viewport?.toJson(),
        "travelAdvisory": travelAdvisory?.toJson(),
        "routeToken": routeToken,
      };
}

class Leg {
  Leg({
    this.distanceMeters,
    this.duration,
    this.staticDuration,
    this.polyline,
    this.startLocation,
    this.endLocation,
    this.steps,
    this.travelAdvisory,
  });

  int? distanceMeters;
  int? duration;
  String? staticDuration;
  Polyline? polyline;
  Location? startLocation;
  Location? endLocation;
  List<Step>? steps;
  LegTravelAdvisory? travelAdvisory;

  factory Leg.fromRawJson(String str) => Leg.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        distanceMeters: json["distanceMeters"],
        duration: json["duration"],
        staticDuration: json["staticDuration"],
        polyline: json["polyline"] == null
            ? null
            : Polyline.fromJson(json["polyline"]),
        startLocation: json["startLocation"] == null
            ? null
            : Location.fromJson(json["startLocation"]),
        endLocation: json["endLocation"] == null
            ? null
            : Location.fromJson(json["endLocation"]),
        steps: json["steps"] == null
            ? []
            : List<Step>.from(json["steps"]!.map((x) => Step.fromJson(x))),
        travelAdvisory: json["travelAdvisory"] == null
            ? null
            : LegTravelAdvisory.fromJson(json["travelAdvisory"]),
      );

  Map<String, dynamic> toJson() => {
        "distanceMeters": distanceMeters,
        "duration": duration,
        "staticDuration": staticDuration,
        "polyline": polyline?.toJson(),
        "startLocation": startLocation?.toJson(),
        "endLocation": endLocation?.toJson(),
        "steps": steps == null
            ? []
            : List<dynamic>.from(steps!.map((x) => x.toJson())),
        "travelAdvisory": travelAdvisory?.toJson(),
      };
}

class Location {
  Location({
    this.latLng,
    this.heading,
  });

  High? latLng;
  int? heading;

  factory Location.fromRawJson(String str) =>
      Location.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        latLng: json["latLng"] == null ? null : High.fromJson(json["latLng"]),
        heading: json["heading"],
      );

  Map<String, dynamic> toJson() => {
        "latLng": latLng?.toJson(),
        "heading": heading,
      };
}

class High {
  High({
    this.latitude,
    this.longitude,
  });

  double? latitude;
  double? longitude;

  factory High.fromRawJson(String str) => High.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory High.fromJson(Map<String, dynamic> json) => High(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}

class Polyline {
  Polyline({
    this.encodedPolyline,
  });

  String? encodedPolyline;

  factory Polyline.fromRawJson(String str) =>
      Polyline.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Polyline.fromJson(Map<String, dynamic> json) => Polyline(
        encodedPolyline: json["encodedPolyline"],
      );

  Map<String, dynamic> toJson() => {
        "encodedPolyline": encodedPolyline,
      };
}

class Step {
  Step({
    this.distanceMeters,
    this.staticDuration,
    this.polyline,
    this.startLocation,
    this.endLocation,
    this.navigationInstruction,
    this.travelAdvisory,
  });

  int? distanceMeters;
  String? staticDuration;
  Polyline? polyline;
  Location? startLocation;
  Location? endLocation;
  NavigationInstruction? navigationInstruction;
  StepTravelAdvisory? travelAdvisory;

  factory Step.fromRawJson(String str) => Step.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        distanceMeters: json["distanceMeters"],
        staticDuration: json["staticDuration"],
        polyline: json["polyline"] == null
            ? null
            : Polyline.fromJson(json["polyline"]),
        startLocation: json["startLocation"] == null
            ? null
            : Location.fromJson(json["startLocation"]),
        endLocation: json["endLocation"] == null
            ? null
            : Location.fromJson(json["endLocation"]),
        navigationInstruction: json["navigationInstruction"] == null
            ? null
            : NavigationInstruction.fromJson(json["navigationInstruction"]),
        travelAdvisory: json["travelAdvisory"] == null
            ? null
            : StepTravelAdvisory.fromJson(json["travelAdvisory"]),
      );

  Map<String, dynamic> toJson() => {
        "distanceMeters": distanceMeters,
        "staticDuration": staticDuration,
        "polyline": polyline?.toJson(),
        "startLocation": startLocation?.toJson(),
        "endLocation": endLocation?.toJson(),
        "navigationInstruction": navigationInstruction?.toJson(),
        "travelAdvisory": travelAdvisory?.toJson(),
      };
}

class NavigationInstruction {
  NavigationInstruction({
    this.maneuver,
    this.instructions,
  });

  String? maneuver;
  String? instructions;

  factory NavigationInstruction.fromRawJson(String str) =>
      NavigationInstruction.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NavigationInstruction.fromJson(Map<String, dynamic> json) =>
      NavigationInstruction(
        maneuver: json["maneuver"],
        instructions: json["instructions"],
      );

  Map<String, dynamic> toJson() => {
        "maneuver": maneuver,
        "instructions": instructions,
      };
}

class StepTravelAdvisory {
  StepTravelAdvisory({
    this.speedReadingIntervals,
  });

  List<SpeedReadingInterval>? speedReadingIntervals;

  factory StepTravelAdvisory.fromRawJson(String str) =>
      StepTravelAdvisory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StepTravelAdvisory.fromJson(Map<String, dynamic> json) =>
      StepTravelAdvisory(
        speedReadingIntervals: json["speedReadingIntervals"] == null
            ? []
            : List<SpeedReadingInterval>.from(json["speedReadingIntervals"]!
                .map((x) => SpeedReadingInterval.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "speedReadingIntervals": speedReadingIntervals == null
            ? []
            : List<dynamic>.from(speedReadingIntervals!.map((x) => x.toJson())),
      };
}

class SpeedReadingInterval {
  SpeedReadingInterval({
    this.startPolylinePointIndex,
    this.endPolylinePointIndex,
    this.speed,
  });

  int? startPolylinePointIndex;
  int? endPolylinePointIndex;
  String? speed;

  factory SpeedReadingInterval.fromRawJson(String str) =>
      SpeedReadingInterval.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SpeedReadingInterval.fromJson(Map<String, dynamic> json) =>
      SpeedReadingInterval(
        startPolylinePointIndex: json["startPolylinePointIndex"],
        endPolylinePointIndex: json["endPolylinePointIndex"],
        speed: json["speed"],
      );

  Map<String, dynamic> toJson() => {
        "startPolylinePointIndex": startPolylinePointIndex,
        "endPolylinePointIndex": endPolylinePointIndex,
        "speed": speed,
      };
}

class LegTravelAdvisory {
  LegTravelAdvisory({
    this.tollInfo,
    this.speedReadingIntervals,
  });

  TollInfo? tollInfo;
  List<SpeedReadingInterval>? speedReadingIntervals;

  factory LegTravelAdvisory.fromRawJson(String str) =>
      LegTravelAdvisory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LegTravelAdvisory.fromJson(Map<String, dynamic> json) =>
      LegTravelAdvisory(
        tollInfo: json["tollInfo"] == null
            ? null
            : TollInfo.fromJson(json["tollInfo"]),
        speedReadingIntervals: json["speedReadingIntervals"] == null
            ? []
            : List<SpeedReadingInterval>.from(json["speedReadingIntervals"]!
                .map((x) => SpeedReadingInterval.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tollInfo": tollInfo?.toJson(),
        "speedReadingIntervals": speedReadingIntervals == null
            ? []
            : List<dynamic>.from(speedReadingIntervals!.map((x) => x.toJson())),
      };
}

class TollInfo {
  TollInfo({
    this.estimatedPrice,
  });

  List<EstimatedPrice>? estimatedPrice;

  factory TollInfo.fromRawJson(String str) =>
      TollInfo.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TollInfo.fromJson(Map<String, dynamic> json) => TollInfo(
        estimatedPrice: json["estimatedPrice"] == null
            ? []
            : List<EstimatedPrice>.from(
                json["estimatedPrice"]!.map((x) => EstimatedPrice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "estimatedPrice": estimatedPrice == null
            ? []
            : List<dynamic>.from(estimatedPrice!.map((x) => x.toJson())),
      };
}

class EstimatedPrice {
  EstimatedPrice({
    this.currencyCode,
    this.units,
    this.nanos,
  });

  String? currencyCode;
  String? units;
  int? nanos;

  factory EstimatedPrice.fromRawJson(String str) =>
      EstimatedPrice.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EstimatedPrice.fromJson(Map<String, dynamic> json) => EstimatedPrice(
        currencyCode: json["currencyCode"],
        units: json["units"],
        nanos: json["nanos"],
      );

  Map<String, dynamic> toJson() => {
        "currencyCode": currencyCode,
        "units": units,
        "nanos": nanos,
      };
}

class Viewport {
  Viewport({
    this.low,
    this.high,
  });

  High? low;
  High? high;

  factory Viewport.fromRawJson(String str) =>
      Viewport.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        low: json["low"] == null ? null : High.fromJson(json["low"]),
        high: json["high"] == null ? null : High.fromJson(json["high"]),
      );

  Map<String, dynamic> toJson() => {
        "low": low?.toJson(),
        "high": high?.toJson(),
      };
}
