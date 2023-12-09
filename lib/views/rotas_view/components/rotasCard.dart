import '../../../export.dart';

class RotasCard extends StatelessWidget {
  const RotasCard(
      {Key? key,
      required this.name,
      this.onPress,
      required this.km,
      required this.isActive})
      : super(key: key);

  final String name;
  final String km;
  final bool isActive;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppConstants().ltWhiteGrey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(horizontal: Get.width * 0.03, vertical: 7),
      child: GestureDetector(
        onTap: onPress, // profile git
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: Get.width * 0.025,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: TextStyle(
                                color: AppConstants().ltBlack,
                                fontFamily: 'Sfbold'),
                          ),
                          10.w.spaceX,
                          isActive == true
                              ? Container(
                                  height: 8,
                                  width: 8,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(16)))
                              : const SizedBox()
                        ],
                      ), // rota adı
                      Text(
                        km,
                        style: TextStyle(
                            color: AppConstants().ltDarkGrey,
                            fontFamily: 'Sflight'),
                      ), // km
                    ],
                  ),
                ],
              ),
              SvgPicture.asset('assets/icons/next-icon.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
