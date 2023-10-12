import 'dart:convert';

class GetRouteDetailsByIdRequestModel {
    GetRouteDetailsByIdRequestModel({
        this.routeId,
    });

    int? routeId;

    factory GetRouteDetailsByIdRequestModel.fromRawJson(String str) => GetRouteDetailsByIdRequestModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetRouteDetailsByIdRequestModel.fromJson(Map<String, dynamic> json) => GetRouteDetailsByIdRequestModel(
        routeId: json["RouteID"],
    );

    Map<String, dynamic> toJson() => {
        "RouteID": routeId,
    };
}

class GetRouteDetailsByIdResponseModel {
    GetRouteDetailsByIdResponseModel({
        this.success,
        this.data,
        this.message,
    });

    int? success;
    List<GetRouteDetailsData>? data;
    String? message;

    factory GetRouteDetailsByIdResponseModel.fromRawJson(String str) => GetRouteDetailsByIdResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetRouteDetailsByIdResponseModel.fromJson(Map<String, dynamic> json) => GetRouteDetailsByIdResponseModel(
        success: json["success"],
        data: json["data"] == null ? [] : List<GetRouteDetailsData>.from(json["data"]!.map((x) => GetRouteDetailsData.fromJson(x))),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
    };
}

class GetRouteDetailsData {
    GetRouteDetailsData({
        this.routeBelongsToMe,
        this.doIHaveAActiveRoute,
        this.isRouteActive,
        this.routeBelongsTo,
        this.route,
        this.myRoute,
    });

    bool? routeBelongsToMe;
    bool? doIHaveAActiveRoute;
    bool? isRouteActive;
    RouteBelongsTo? routeBelongsTo;
    Route? route;
    Route? myRoute;

    factory GetRouteDetailsData.fromRawJson(String str) => GetRouteDetailsData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetRouteDetailsData.fromJson(Map<String, dynamic> json) => GetRouteDetailsData(
        routeBelongsToMe: json["routeBelongsToMe"],
        doIHaveAActiveRoute: json["doIHaveAActiveRoute"],
        isRouteActive: json["isRouteActive"],
        routeBelongsTo: json["routeBelongsTo"] == null ? null : RouteBelongsTo.fromJson(json["routeBelongsTo"]),
        route: json["route"] == null ? null : Route.fromJson(json["route"]),
        myRoute: json["myRoute"] == null ? null : Route.fromJson(json["myRoute"]),
    );

    Map<String, dynamic> toJson() => {
        "routeBelongsToMe": routeBelongsToMe,
        "doIHaveAActiveRoute": doIHaveAActiveRoute,
        "isRouteActive": isRouteActive,
        "routeBelongsTo": routeBelongsTo?.toJson(),
        "route": route?.toJson(),
        "myRoute": myRoute?.toJson(),
    };
}

class Route {
    Route({
        this.id,
        this.userId,
        this.departureDate,
        this.arrivalDate,
        this.routeDescription,
        this.vehicleCapacity,
        this.isActive,
        this.startingCoordinates,
        this.startingOpenAdress,
        this.startingCity,
        this.endingCoordinates,
        this.endingOpenAdress,
        this.endingCity,
        this.distance,
        this.travelTime,
        this.polylineEncode,
        this.polylineDecode,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    int? userId;
    DateTime? departureDate;
    DateTime? arrivalDate;
    String? routeDescription;
    int? vehicleCapacity;
    bool? isActive;
    List<double>? startingCoordinates;
    String? startingOpenAdress;
    String? startingCity;
    List<double>? endingCoordinates;
    String? endingOpenAdress;
    String? endingCity;
    int? distance;
    int? travelTime;
    String? polylineEncode;
    List<List<double>>? polylineDecode;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory Route.fromRawJson(String str) => Route.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Route.fromJson(Map<String, dynamic> json) => Route(
        id: json["id"],
        userId: json["userID"],
        departureDate: json["departureDate"] == null ? null : DateTime.parse(json["departureDate"]),
        arrivalDate: json["arrivalDate"] == null ? null : DateTime.parse(json["arrivalDate"]),
        routeDescription: json["routeDescription"],
        vehicleCapacity: json["vehicleCapacity"],
        isActive: json["isActive"],
        startingCoordinates: json["startingCoordinates"] == null ? [] : List<double>.from(json["startingCoordinates"]!.map((x) => x?.toDouble())),
        startingOpenAdress: json["startingOpenAdress"],
        startingCity: json["startingCity"],
        endingCoordinates: json["endingCoordinates"] == null ? [] : List<double>.from(json["endingCoordinates"]!.map((x) => x?.toDouble())),
        endingOpenAdress: json["endingOpenAdress"],
        endingCity: json["endingCity"],
        distance: json["distance"],
        travelTime: json["travelTime"],
        polylineEncode: json["polylineEncode"],
        polylineDecode: json["polylineDecode"] == null ? [] : List<List<double>>.from(json["polylineDecode"]!.map((x) => List<double>.from(x.map((x) => x?.toDouble())))),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userID": userId,
        "departureDate": departureDate?.toIso8601String(),
        "arrivalDate": arrivalDate?.toIso8601String(),
        "routeDescription": routeDescription,
        "vehicleCapacity": vehicleCapacity,
        "isActive": isActive,
        "startingCoordinates": startingCoordinates == null ? [] : List<dynamic>.from(startingCoordinates!.map((x) => x)),
        "startingOpenAdress": startingOpenAdress,
        "startingCity": startingCity,
        "endingCoordinates": endingCoordinates == null ? [] : List<dynamic>.from(endingCoordinates!.map((x) => x)),
        "endingOpenAdress": endingOpenAdress,
        "endingCity": endingCity,
        "distance": distance,
        "travelTime": travelTime,
        "polylineEncode": polylineEncode,
        "polylineDecode": polylineDecode == null ? [] : List<dynamic>.from(polylineDecode!.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };
}

class RouteBelongsTo {
    RouteBelongsTo({
        this.id,
        this.name,
        this.surname,
        this.profilePicture,
        this.usertousercartypes,
    });

    int? id;
    String? name;
    String? surname;
    String? profilePicture;
    List<GetRouteDetailsUsertousercartype>? usertousercartypes;

    factory RouteBelongsTo.fromRawJson(String str) => RouteBelongsTo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory RouteBelongsTo.fromJson(Map<String, dynamic> json) => RouteBelongsTo(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        profilePicture: json["profilePicture"],
        usertousercartypes: json["usertousercartypes"] == null ? [] : List<GetRouteDetailsUsertousercartype>.from(json["usertousercartypes"]!.map((x) => GetRouteDetailsUsertousercartype.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "profilePicture": profilePicture,
        "usertousercartypes": usertousercartypes == null ? [] : List<dynamic>.from(usertousercartypes!.map((x) => x.toJson())),
    };
}

class GetRouteDetailsUsertousercartype {
    GetRouteDetailsUsertousercartype({
        this.id,
        this.carBrand,
        this.carModel,
    });

    int? id;
    String? carBrand;
    String? carModel;

    factory GetRouteDetailsUsertousercartype.fromRawJson(String str) => GetRouteDetailsUsertousercartype.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory GetRouteDetailsUsertousercartype.fromJson(Map<String, dynamic> json) => GetRouteDetailsUsertousercartype(
        id: json["id"],
        carBrand: json["carBrand"],
        carModel: json["carModel"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "carBrand": carBrand,
        "carModel": carModel,
    };
}