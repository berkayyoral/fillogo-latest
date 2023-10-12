import 'package:fillogo/controllers/drawer/drawer_controller.dart';
import 'package:fillogo/export.dart';
import 'package:flutter/gestures.dart';

class ForgetPasswordView extends StatelessWidget {
  ForgetPasswordView({Key? key}) : super(key: key);
  TextEditingController epostaController = TextEditingController();
  GeneralDrawerController drawerControl = Get.find();

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
          'Parolayı Sıfırla',
          style: TextStyle(
              fontFamily: 'Sfsemibold',
              color: AppConstants().ltLogoGrey,
              fontSize: 28),
        ),
      ),
      body: Column(
        children: [
          Center(child: DummyBox15()),
          DummyBox15(),
          SizedBox(
            height: 60,
            width: 300,
            child: Text(
              'Lütfen hesabınıza kayıtlı olan e-posta\n adresinizi giriniz.',
              textAlign: TextAlign.start,
            ),
          ),
          // CustomTextField(hintText: 'E-posta', controller: epostaController),
          DummyBox15(),
          RedButton(
            text: 'Doğrulama Gönder',
            onpressed: () {
              Get.offAndToNamed(NavigationConstants.authentication);
            },
          ),
          DummyBox15(),
          SizedBox(
            width: 320,
            child: RichText(
                text: TextSpan(children: [
              TextSpan(text: 'Bir hesabınız yok mu? '),
              TextSpan(
                text: 'Üye Ol',
                style: TextStyle(
                  fontFamily: 'Sfsemibold',
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => Get.offAndToNamed(NavigationConstants.register),
              ),
            ], style: TextStyle(color: AppConstants().ltBlack))),
          )
        ],
      ),
    );
  }
}
