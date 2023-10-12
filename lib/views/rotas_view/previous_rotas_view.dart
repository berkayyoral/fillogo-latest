import 'package:fillogo/controllers/map/route_calculate_view_controller.dart';
import 'package:fillogo/export.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PreviousRotasView extends StatefulWidget {
  const PreviousRotasView({Key? key}) : super(key: key);

  @override
  State<PreviousRotasView> createState() => _PreviousRotasViewState();
}

class _PreviousRotasViewState extends State<PreviousRotasView> {

  String _startAddress = '';
  String _destinationAddress = '';
  String? _placeDistance;
  // RouteCalculatesViewController currentDirectionsController =
  //     Get.put(RouteCalculatesViewController());

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
  }

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();
  // _getAddress() async {
  //   try {
  //     List<Placemark> p = await placemarkFromCoordinates(
  //         currentDirectionsController.latitude.value,
  //         currentDirectionsController.longitude.value);

  //     Placemark place = p[0];
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // Widget _textField({
  //   required TextEditingController controller,
  //   required String hint,
  //   required FocusNode focusNode,
  //   required Function(String) locationCallback,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 20, right: 20),
  //     child: Container(
  //       width: Get.width * 0.8,
  //       height: 50,
  //       decoration: BoxDecoration(
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.grey.withOpacity(0.2),
  //             spreadRadius: 5,
  //             blurRadius: 7,
  //             offset: const Offset(0, 3), // changes position of shadow
  //           ),
  //         ],
  //       ),
  //       child: TextField(
  //         controller: controller,
  //         focusNode: focusNode,
  //         cursorColor: AppConstants().ltMainRed,
  //         decoration: InputDecoration(
  //           suffixIcon: const Icon(Icons.location_on_outlined),
  //           hintText: hint,
  //           hintStyle: TextStyle(
  //             fontFamily: "Sflight",
  //             fontSize: 16,
  //             color: AppConstants().ltDarkGrey,
  //           ),
  //           border: const OutlineInputBorder(
  //             borderRadius: BorderRadius.all(
  //               Radius.circular(10.0),
  //             ),
  //             borderSide: BorderSide.none,
  //           ),
  //           filled: true,
  //           fillColor: Colors.white,
  //         ),
  //         style: TextStyle(
  //           fontFamily: "Sflight",
  //           fontSize: 16,
  //           color: AppConstants().ltBlack,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Future<bool> _calculateDistance() async {
  //   print("XXXXXXXXXXXXXXX  111111");
  //   try {
  //     List<Location> startPlacemark = await locationFromAddress(_startAddress);
  //     List<Location> destinationPlacemark =
  //         await locationFromAddress(_destinationAddress);

  //     double startLatitude = startPlacemark[0].latitude;
  //     double startLongitude = startPlacemark[0].longitude;
  //     double destinationLatitude = destinationPlacemark[0].latitude;
  //     double destinationLongitude = destinationPlacemark[0].longitude;
  //     String startCoordinatesString = '($startLatitude, $startLongitude)';
  //     String destinationCoordinatesString =
  //         '($destinationLatitude, $destinationLongitude)';

  //     print(
  //       'START COORDINATES: ($startLatitude, $startLongitude)',
  //     );
  //     print(
  //       'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
  //     );

  //     double miny = (startLatitude <= destinationLatitude)
  //         ? startLatitude
  //         : destinationLatitude;
  //     double minx = (startLongitude <= destinationLongitude)
  //         ? startLongitude
  //         : destinationLongitude;
  //     double maxy = (startLatitude <= destinationLatitude)
  //         ? destinationLatitude
  //         : startLatitude;
  //     double maxx = (startLongitude <= destinationLongitude)
  //         ? destinationLongitude
  //         : startLongitude;

  //     double southWestLatitude = miny;
  //     double southWestLongitude = minx;

  //     double northEastLatitude = maxy;
  //     double northEastLongitude = maxx;


  //     double totalDistance = 0.0;

  //     return true;
  //   } catch (e) {
  //     print(e);
  //   }
  //   print("XXXXXXXXXXXXXXX  222222");
  //   return false;
  // }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarGenel(
        title: Text(
          'Önceki Rotam',
          style: TextStyle(
              fontFamily: 'Sfsemibold',
              color: AppConstants().ltLogoGrey,
              fontSize: 28),
        ),
        actions: [],
        leading: const SizedBox(),
      ),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.4), BlendMode.dstATop),
              image: const AssetImage('assets/images/world-bg-1.png'),
              fit: BoxFit.fitHeight),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const DummyBox15(),
                Row(
                  children: [
                    25.w.spaceX,
                    Text(
                      'Rotanız',
                      style: TextStyle(fontFamily: 'Sflight'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    25.w.spaceX,
                    Text(
                      'Samsun -> Ankara',
                      style: TextStyle(fontFamily: 'Sfsemibold'),
                    ),
                  ],
                ),
                Row(
                  children: [
                    25.w.spaceX,
                    Text(
                      'Tahmini 412 km ve 4 Saat 23 Dakika',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                const DummyBox15(),
                Container(
                  height: Get.height * 0.6,
                  width: Get.width * 0.9,
                  child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                          target: LatLng(39.929591, 32.853197), zoom: 10)),
                )

              ],
            ),
          ],
        ),
      ),
    );
  }
}
