

import '../../export.dart';

class ChangeLanguageView extends StatelessWidget {
  ChangeLanguageView({Key? key}) : super(key: key);

  final LanguageController languageController = Get.find();

  final List<LangugageModel> languages = [
    LangugageModel(title: 'Türkçe', languageCode: 'tr'),
    LangugageModel(title: 'İngilizce', languageCode: 'en'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second'.tr),
      ),
      body: ListView.builder(
        itemCount: languages.length,
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              languageController.updateLocale(languages[index].languageCode);
            },
            child: Text(
              languages[index].title,
              style: const TextStyle(fontFamily: "Sfuidisplay"),
            ),
          );
        }),
      ),
    );
  }
}
