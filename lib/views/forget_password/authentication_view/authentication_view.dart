import 'package:fillogo/export.dart';
import 'package:pinput/pinput.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarGenel(
        leading: InkWell(
          onTap: () => Get.offAndToNamed(NavigationConstants.welcomelogin),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset(
              'assets/icons/back-icon.svg',
              color: AppConstants().ltLogoGrey,
            ),
          ),
        ),
        title: Text(
          'Kimlik Doğrulama',
          style: TextStyle(
              fontFamily: 'Sfsemibold',
              color: AppConstants().ltLogoGrey,
              fontSize: 28),
        ),
      ),
      body: Column(children: [
        Center(child: DummyBox15()),
        DummyBox15(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Text(
            //TODO: SfRegular yok
            "Lütfen e-posta adresinize gelen 6 haneli doğrulama kodunu giriniz.",
            style: TextStyle(fontSize: 14),
          ),
        ),
        10.h.spaceY,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Row(
            children: [
              Text(
                "ahmet@gmail.com",
                style: TextStyle(fontFamily: 'Sfsemibold', fontSize: 14),
              ),
            ],
          ),
        ),
        DummyBox15(),
        DummyBox15(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Pinput(
            length: 6,
            defaultPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(30, 60, 87, 1),
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]),
            ),
            focusedPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(30, 60, 87, 1),
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]),
            ),
            submittedPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(30, 60, 87, 1),
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]),
            ),
            followingPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(30, 60, 87, 1),
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]),
            ),
            disabledPinTheme: PinTheme(
              width: 50,
              height: 50,
              textStyle: TextStyle(
                  fontSize: 20,
                  color: Color.fromRGBO(30, 60, 87, 1),
                  fontWeight: FontWeight.w600),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    ),
                  ]),
            ),
          ),
        ),
        DummyBox15(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Row(
            children: [
              Text(
                "Yeniden kod gönder",
                style: TextStyle(
                  fontFamily: "Sfbold",
                  decoration: TextDecoration.underline,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text("01.59")
            ],
          ),
        ),
        DummyBox15(),
        RedButton(
          text: "Doğrula",
          onpressed: () {},
        ),
        DummyBox15(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: Row(
            children: [Text("E-posta adresini Numarasını Düzenle")],
          ),
        )
      ]),
    );
  }
}
