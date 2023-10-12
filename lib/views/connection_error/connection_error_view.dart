import '../../export.dart';

class ConnectionErrorView extends StatelessWidget {
  ConnectionErrorView({Key? key}) : super(key: key);

  final ConnectionController connectionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/connection-error-icon.svg',
                height: Get.width * 0.5, color: AppConstants().ltMainRed),
            Center(
              child: SizedBox(
                width: Get.width * 0.8,
                child: Text(
                  "İnternet bağlantınızda bir problem fark ettik! Lütfen internet bağlantınızı kontrol ediniz ve tekrar deneyiniz.",
                  style: TextStyle(
                    fontFamily: "Sfregular",
                    fontSize: 16,
                    color: AppConstants().ltBlack,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            30.h.spaceY,
            RedButton(
              text: 'Bağlantıyı kontrol et',
              onpressed: () {
                connectionController.checkConnection();
              },
            ),
          ],
        ),
      ),
    );
  }
}
