import 'package:flutter_switch/flutter_switch.dart';

import '../export.dart';

class PopupNewPost extends StatefulWidget {
  const PopupNewPost({Key? key}) : super(key: key);

  @override
  State<PopupNewPost> createState() => _PopupNewPostState();
}

class _PopupNewPostState extends State<PopupNewPost> {
  bool statusRoute = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.all(12),
          width: Get.width,
          height: statusRoute == true ? Get.height * 0.42 : Get.height * 0.25,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Row(
                children: [
                  Card(
                    elevation: 0,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: SizedBox(
                        height: 50,
                        width: Get.width * 0.85,
                        child: ListTile(
                          title: Text(
                            statusRoute == true
                                ? 'Gönderiye rota ekle'
                                : 'Rotasız gönderi paylaş',
                            style: const TextStyle(fontFamily: 'Sfbold'),
                          ),
                          subtitle: Text(
                            statusRoute == true
                                ? 'Eğer rota eklemek istemiyorsan bunu kapatabilirsin'
                                : 'Eğer rota eklemek istiyorsan bunu açabilirsin',
                            style: const TextStyle(fontSize: 10),
                          ),
                          trailing: SizedBox(
                            width: 50,
                            height: 30,
                            child: FlutterSwitch(
                              activeToggleColor:
                                  const Color.fromARGB(255, 107, 221, 69),
                              inactiveToggleColor: Colors.white,
                              inactiveColor: const Color(0xffDDDDDD),
                              activeColor: const Color(0xffDDDDDD),
                              showOnOff: false,
                              //activeText: 'on',
                              //activeTextColor: const Color(0xff8AD96F),
                              //inactiveText: 'off',
                              //inactiveTextColor: AppConstants().ltDarkGrey,
                              toggleSize: 28,
                              padding: 2,
                              borderRadius: 16,
                              value: statusRoute,
                              onToggle: (val) {
                                setState(() {
                                  statusRoute = val;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              statusRoute == true ? const DummyBox15() : const SizedBox(),
              statusRoute == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        width: Get.width * 0.8,
                        height: 50,
                        child: TextField(
                          cursorColor: AppConstants().ltMainRed,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.location_on_outlined),
                            hintText: "Çıkış Noktasını Seçiniz",
                            hintStyle: TextStyle(
                              fontFamily: "Sflight",
                              fontSize: 16,
                              color: AppConstants().ltDarkGrey,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(left: 15),
                          ),
                          style: TextStyle(
                            fontFamily: "Sflight",
                            fontSize: 16,
                            color: AppConstants().ltBlack,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              15.h.spaceY,
              statusRoute == true
                  ? Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        width: Get.width * 0.8,
                        height: 50,
                        child: TextField(
                          cursorColor: AppConstants().ltMainRed,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.location_on_outlined),
                            hintText: "Varış Noktasını Seçiniz",
                            hintStyle: TextStyle(
                              fontFamily: "Sflight",
                              fontSize: 16,
                              color: AppConstants().ltDarkGrey,
                            ),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.only(left: 15),
                          ),
                          style: TextStyle(
                            fontFamily: "Sflight",
                            fontSize: 16,
                            color: AppConstants().ltBlack,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              15.h.spaceY,
              SizedBox(
                width: Get.width * 0.8,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (statusRoute == true) {
                      Get.offAndToNamed(NavigationConstants.route);
                    } else {
                      Get.offAndToNamed(NavigationConstants.newroute);
                    }
                  },
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
