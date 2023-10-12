import 'package:fillogo/export.dart';

class DemoInfoPopupView extends StatelessWidget {
  const DemoInfoPopupView({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          'Demo Sürüm Kullanım Sınırı',
          style: TextStyle(
            fontFamily: "Sfbold",
            fontSize: 20,
            color: AppConstants().ltBlack,
          ),
        ),
      ),
      content: Text(
        'Uygulamanın demo sürümünü kullanmaktasınız. Demo sürümde bu bölüm kullanıma açık değildir.',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: "Sfregular",
          fontSize: 16,
          color: AppConstants().ltBlack,
        ),
      ),
      actions: <Widget>[
        RedButton(
          text: 'Tamam',
          onpressed: () => Navigator.pop(
            context,
            'Tamam',
          ),
        ),
      ],
    );
  }
}
