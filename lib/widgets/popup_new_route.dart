import '../export.dart';

class PopupNewRoute extends StatelessWidget {
  const PopupNewRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Container(
          width: Get.width,
          height: Get.height * 0.45,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                'assets/images/world-bg-1.png',
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20, left: 50, right: 20),
                    child: Text(
                      "İyi günler, Ahmet",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 18,
                        color: Color(0xff454545),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 50, right: 20),
                child: Row(
                  children: [
                    Text(
                      "Rotanı bildirir misin?",
                      style: TextStyle(
                        fontFamily: "Sfsemibold",
                        fontSize: 18,
                        color: Color(0xff000000),
                      ),
                    ),
                  ],
                ),
              ),
              15.h.spaceY,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: Get.width * 0.8,
                  height: 50,
                  child: TextField(
                    cursorColor: AppConstants().ltMainRed,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.location_on_outlined),
                      hintText: "Çıkış Noktasını Seçiniz",
                      hintStyle: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 16,
                        color: AppConstants().ltDarkGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    style: TextStyle(
                      fontFamily: "Sflight",
                      fontSize: 16,
                      color: AppConstants().ltBlack,
                    ),
                  ),
                ),
              ),
              15.h.spaceY,
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  width: Get.width * 0.8,
                  height: 50,
                  child: TextField(
                    cursorColor: AppConstants().ltMainRed,
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.location_on_outlined),
                      hintText: "Varış Noktasını Seçiniz",
                      hintStyle: TextStyle(
                        fontFamily: "Sflight",
                        fontSize: 16,
                        color: AppConstants().ltDarkGrey,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 15),
                    ),
                    style: TextStyle(
                      fontFamily: "Sflight",
                      fontSize: 16,
                      color: AppConstants().ltBlack,
                    ),
                  ),
                ),
              ),
              15.h.spaceY,
              SizedBox(
                width: Get.width * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: AppConstants().ltMainRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Devam Et",
                    style: TextStyle(
                      fontFamily: "Sfsemidold",
                      fontSize: 16,
                      color: AppConstants().ltWhite,
                    ),
                  ),
                ),
              ),
              15.h.spaceY,
            ],
          ),
        ),
      ),
    );
  }
}
