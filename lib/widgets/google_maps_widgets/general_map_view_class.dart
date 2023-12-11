import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../export.dart';

class GeneralMapViewClass extends StatelessWidget {
  GeneralMapViewClass(
      {super.key,
      this.markerSet,
      this.initialCameraPosition,
      this.myLocationEnabled,
      this.myLocationButtonEnabled,
      this.mapType,
      this.zoomGesturesEnabled,
      this.zoomControlsEnabled,
      this.polylinesSet,
      this.mapController,
      this.onCameraMoveStarted,
      this.onCameraMove,
      this.polygonsSet,
      this.oncameraIdle,
      this.tileOverlaysSet,
      this.mapController2});

  Set<Marker>? markerSet;
  CameraPosition? initialCameraPosition;
  bool? myLocationEnabled;
  bool? zoomGesturesEnabled;
  MapType? mapType;
  bool? myLocationButtonEnabled;
  bool? zoomControlsEnabled;
  Set<Polyline>? polylinesSet;
  GoogleMapController? mapController;
  Function(GoogleMapController)? mapController2;
  Function()? onCameraMoveStarted;
  Function()? oncameraIdle;
  Function(CameraPosition)? onCameraMove;
  Set<Polygon>? polygonsSet;
  Set<TileOverlay>? tileOverlaysSet;

  //MapPageController mapPageController = Get.find<MapPageController>();

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      markers: markerSet!,
      polygons: polygonsSet!,
      tileOverlays: tileOverlaysSet!,
      onCameraMoveStarted: onCameraMoveStarted,
      onCameraMove: onCameraMove,
      onCameraIdle: oncameraIdle,
      initialCameraPosition: initialCameraPosition!,
      myLocationEnabled: myLocationEnabled!,
      myLocationButtonEnabled: myLocationButtonEnabled!,
      mapType: mapType!,
      zoomGesturesEnabled: zoomGesturesEnabled!,
      zoomControlsEnabled: zoomControlsEnabled!,
      polylines: polylinesSet!,
      onMapCreated: mapController2,
    );
  }
}
