class TaskDetail {
  final double lat;
  final double lon;
  final double finishLat;
  final double finishLon;
  TaskDetail(this.lat, this.lon, this.finishLat, this.finishLon);
  TaskDetail.fromJson(Map<String, dynamic> data)
      : lat = double.parse(data['lat']),
        lon = double.parse(data['lon']),
        finishLat = double.parse(data['finishLat']),
        finishLon = double.parse(data['finishLon']);
}
