class AddVehicleInfoRequestModel {
  String? carBrand;
  String? carModel;
  int? carCapacity;
  String? plateNumber;
  int? carTypeID;

  AddVehicleInfoRequestModel(
      {this.carBrand,
      this.carModel,
      this.carCapacity,
      this.plateNumber,
      this.carTypeID});

  AddVehicleInfoRequestModel.fromJson(Map<String, dynamic> json) {
    carBrand = json['carBrand'];
    carModel = json['carModel'];
    carCapacity = json['carCapacity'];
    plateNumber = json['plateNumber'];
    carTypeID = json['carTypeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['carBrand'] = carBrand;
    data['carModel'] = carModel;
    data['carCapacity'] = carCapacity;
    data['plateNumber'] = plateNumber;
    data['carTypeID'] = carTypeID;
    return data;
  }
}

class AddVehicleInfoResponseModel {
  int? succes;
  List<dynamic>? data;
  String? message;

  AddVehicleInfoResponseModel({this.succes, this.data, this.message});

  AddVehicleInfoResponseModel.fromJson(Map<String, dynamic> json) {
    succes = json['succes'];

    data = List.castFrom<dynamic, dynamic>(json['data']);
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['succes'] = succes;
    data['data'] = data;
    data['message'] = message;
    return data;
  }
}
