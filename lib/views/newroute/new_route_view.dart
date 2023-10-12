import 'package:fillogo/controllers/stepper/post_controller.dart';
import 'package:fillogo/widgets/navigation_drawer.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';

import '../../export.dart';
import 'components/new_route_appBar.dart';

class NewRouteView extends StatelessWidget {
  NewRouteView({Key? key}) : super(key: key);
  final PostController postController = Get.find();
  TextEditingController aciklamaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newRouteAppBar(),
      drawer:  NavigationDrawerWidget(),
      body: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/world-bg-1.png'), fit: BoxFit.fitHeight),
        ),
        child: Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: AppConstants().ltMainRed,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Obx(
                  () => Stepper(
                    type: StepperType.vertical,
                    steps: getSteps(),
                    currentStep: postController.currentStep,
                    controlsBuilder: (context, details) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (aciklamaController.text.isNotEmpty) {
                                  if (postController.currentStep < 1) {
                                    postController.arttir();
                                  } else if (postController.currentStep == 1) {
                                    Get.offAndToNamed(NavigationConstants.postflow);
                                  }
                                }
                              },
                              child: Obx(
                                () => Container(
                                  height: Get.height * 0.04,
                                  width: Get.width * 0.16,
                                  decoration: BoxDecoration(
                                    color: postController.buttonColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(
                                    child: Text(
                                      postController.currentStep == 1 ? 'Paylaş' : 'İleri',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Sfbold',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: Get.width * 0.05,
                            ),
                            postController.currentStep == 0
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      postController.azalt();
                                    },
                                    child: Container(
                                      height: Get.height * 0.04,
                                      width: Get.width * 0.16,
                                      decoration: BoxDecoration(
                                        color: AppConstants().ltWhiteGrey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Geri',
                                          style: TextStyle(
                                            color: AppConstants().ltDarkGrey,
                                            fontFamily: 'Sfbold',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GestureDetector(
                  onTap: () {
                    Get.offAndToNamed(NavigationConstants.generalSettings);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width * 0.1,
                      ),
                      Text(
                        'Genel Ayarları Düzenle',
                        style: TextStyle(color: AppConstants().ltMainRed, fontSize: 16, fontFamily: 'Sfsemibold'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() {
    return [
      Step(
        isActive: postController.currentStep >= 0 ? true : false,
        title: Text(
          "Açıklama (Zorunlu)",
          style: TextStyle(
            fontFamily: 'Sfbold',
            color: AppConstants().ltMainRed,
          ),
        ),
        content: Card(
          elevation: 10,
          child: SizedBox(
            width: Get.width * 0.85,
            child: TextFormField(
              onChanged: (value) {
                if (aciklamaController.text.isNotEmpty) {
                  postController.buttonColor = MaterialColor(
                    AppConstants().ltMainRed.value,
                    <int, Color>{
                      50: AppConstants().ltMainRed,
                    },
                  );
                  //print(postController.buttonColor);
                } else {
                  postController.buttonColor = MaterialColor(
                    AppConstants().ltDarkGrey.value,
                    <int, Color>{
                      50: AppConstants().ltDarkGrey,
                    },
                  );
                  //print(postController.buttonColor);
                }
              },
              controller: aciklamaController,
              minLines: 6,
              maxLines: 8,
              decoration: InputDecoration(
                fillColor: AppConstants().ltWhite,
                filled: true,
                hintText: 'Yeni rotanız hakkında arkadaşlarınıza ne söylemek istersiniz?',
                hintStyle: TextStyle(fontSize: 14),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppConstants().ltWhite,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppConstants().ltWhite),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppConstants().ltWhite,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
      ),
      Step(
        isActive: postController.currentStep >= 1 ? true : false,
        title: Text(
          "Fotoğraf",
          style: TextStyle(
            fontFamily: 'Sfbold',
            color: postController.currentStep >= 1 ? AppConstants().ltMainRed : AppConstants().ltDarkGrey,
          ),
        ),
        content: Container(
          // TODO: foto yukleme islemleri yapılacak
          height: Get.height * 0.15,
          width: Get.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.7),
            boxShadow: [],
            borderRadius: BorderRadius.circular(5),
            border: RDottedLineBorder.all(
              dottedLength: 15,
              dottedSpace: 5,
              width: 1,
              color: AppConstants().ltMainRed.withOpacity(0.7),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.photo,
                color: AppConstants().ltMainRed.withOpacity(0.7),
                size: Get.height * 0.07,
              ),
              Text(
                'Fotoğraf Ekle',
                style: TextStyle(
                  color: AppConstants().ltMainRed.withOpacity(0.7),
                  fontFamily: 'Sfbold',
                ),
              ),
              Text(
                '(Maksimum boyut: 20 MB)',
                style: TextStyle(
                  color: AppConstants().ltMainRed.withOpacity(0.7),
                  fontFamily: 'Sfbold',
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}
