import 'package:fillogo/export.dart';

class UserVehicleInfosWidget extends StatelessWidget {
  const UserVehicleInfosWidget({
    super.key,
    this.vehicleType,
    this.vehicleBrand,
    this.vehicleModel,
  });

  final String? vehicleType;
  final String? vehicleBrand;
  final String? vehicleModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                top: 4.h,
              ),
              child: Text(
                'Araç Tipi:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Sfbold',
                  color: AppConstants().ltLogoGrey,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.w,
                top: 4.h,
              ),
              child: Text(
                vehicleType!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Sflight',
                  color: AppConstants().ltLogoGrey,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                top: 4.h,
              ),
              child: Text(
                'Araç Markası:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Sfbold',
                  color: AppConstants().ltLogoGrey,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.w,
                top: 4.h,
              ),
              child: Text(
                vehicleBrand!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Sflight',
                  color: AppConstants().ltLogoGrey,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: 12.w,
                top: 4.h,
              ),
              child: Text(
                'Araç Modeli:',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Sfbold',
                  color: AppConstants().ltLogoGrey,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 8.w,
                top: 4.h,
              ),
              child: Text(
                vehicleModel!,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontFamily: 'Sflight',
                  color: AppConstants().ltLogoGrey,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
