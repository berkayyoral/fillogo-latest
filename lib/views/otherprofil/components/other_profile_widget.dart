import 'package:fillogo/export.dart';

class OtherProfileWidget extends StatelessWidget {
  const OtherProfileWidget(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.vehicleType,
      required this.plate,
      required this.description,
      required this.followers,
      required this.following,
      required this.journeys})
      : super(key: key);
  final String imageUrl;
  final String name;
  final String vehicleType;
  final String plate;
  final String description;
  final int followers;
  final int following;
  final int journeys;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SvgPicture.asset('assets/icons/follow-it-icon.svg',
                  height: 70, color: AppConstants().ltLogoGrey),
              Text(
                "Takip Et",
                style: TextStyle(
                    fontFamily: "Sfbold",
                    fontSize: 14,
                    color: AppConstants().ltLogoGrey),
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network(imageUrl)),
          Column(
            children: [
              SvgPicture.asset('assets/icons/send-message-icon.svg',
                  height: 70, color: AppConstants().ltLogoGrey),
              Text(
                "Mesaj Gönder",
                style: TextStyle(
                    fontFamily: "Sfbold",
                    fontSize: 14,
                    color: AppConstants().ltLogoGrey),
              ),
            ],
          ),
        ],
      ),
      Text(
        name,
        style: TextStyle(
            fontFamily: "Sfbold", fontSize: 20, color: AppConstants().ltBlack),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            vehicleType,
            style: TextStyle(
                fontFamily: "Sfmedium",
                fontSize: 13,
                color: AppConstants().ltDarkGrey),
          ),
          Text(
            " Şöförü",
            style: TextStyle(
                fontFamily: "Sfmedium",
                fontSize: 13,
                color: AppConstants().ltDarkGrey),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(left: 10, right: 10, top: 15),
        child: Text(
          description,
          style: TextStyle(
              fontFamily: "Sflight",
              fontSize: 15,
              color: AppConstants().ltLogoGrey),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Araç Tipi: ',
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 10,
                        color: AppConstants().ltDarkGrey),
                  ),
                  TextSpan(
                    text: vehicleType.toUpperCase(),
                    style: TextStyle(
                        fontFamily: "Sfsemibold",
                        fontSize: 10,
                        color: AppConstants().ltDarkGrey),
                  ),
                  TextSpan(
                    text: '     Plaka: ',
                    style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 10,
                        color: AppConstants().ltDarkGrey),
                  ),
                  TextSpan(
                    text: plate,
                    style: TextStyle(
                        fontFamily: "Sfsemibold",
                        fontSize: 10,
                        color: AppConstants().ltDarkGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      15.h.spaceY,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Get.offAndToNamed(NavigationConstants.deneme);
            },
            child: Column(
              children: [
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Takipçi',
                        style: TextStyle(
                            fontFamily: "Sfmedium",
                            fontSize: 13,
                            color: AppConstants().ltDarkGrey),
                      ),
                    ],
                  ),
                ),
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: followers.toString(),
                        style: TextStyle(
                            fontFamily: "Sfbold",
                            fontSize: 13,
                            color: AppConstants().ltBlack),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Takip Edilen',
                      style: TextStyle(
                          fontFamily: "Sfmedium",
                          fontSize: 13,
                          color: AppConstants().ltDarkGrey),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: following.toString(),
                      style: TextStyle(
                          fontFamily: "Sfbold",
                          fontSize: 13,
                          color: AppConstants().ltBlack),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Yolculuklar',
                      style: TextStyle(
                          fontFamily: "Sfmedium",
                          fontSize: 13,
                          color: AppConstants().ltDarkGrey),
                    ),
                  ],
                ),
              ),
              RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: journeys.toString(),
                      style: TextStyle(
                          fontFamily: "Sfbold",
                          fontSize: 13,
                          color: AppConstants().ltBlack),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      10.h.spaceY,
      Divider(height: 2, color: AppConstants().ltLogoGrey.withOpacity(0.3)),
      10.h.spaceY,
    ]);
  }
}
