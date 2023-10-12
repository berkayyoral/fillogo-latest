// import 'package:fillogo/export.dart';
// import 'package:flutter_switch/flutter_switch.dart';

// class AddVehicleView extends StatefulWidget {
//   AddVehicleView({super.key});

//   @override
//   State<AddVehicleView> createState() => _AddVehicleViewState();
// }

// class _AddVehicleViewState extends State<AddVehicleView> {
//   TextEditingController numberPlateController = TextEditingController();
//   TextEditingController capacityController = TextEditingController();
//   TextEditingController mailController = TextEditingController();

//   bool toggle = false;
//   int? dropdownValue;
//   int? brandValue;
//   int? modelValue;

//   List<DropdownMenuItem<int>>? items = [];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: Get.width,
//           height: Get.height,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               fit: BoxFit.fill,
//               image: AssetImage('assets/images/6-1.png'),
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//                 vertical: Get.height * 0.18, horizontal: Get.width * 0.04),
//             child: BlurryContainer(
//               blur: 10,
//               color: Colors.transparent,
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(16),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: Get.width * 0.8,
//                     height: 50,
//                     child: const Text(
//                       "Araç Ekle",
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         fontFamily: "Sfblack",
//                         fontSize: 35,
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                   CustomTextField(
//                       hintText: 'Telefon veya E-posta',
//                       controller: mailController),
//                   DummyBox15(),
//                   Container(
//                     width: Get.width * 0.8,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: AppConstants().ltWhite,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       child: DropdownButton(
//                         iconEnabledColor: AppConstants().ltDarkGrey,
//                         underline: SizedBox(),
//                         isExpanded: true,
//                         borderRadius: BorderRadius.circular(8),
//                         hint: Text(
//                           "Araç Tipi Seç",
//                           style: TextStyle(
//                             fontFamily: "Sfmedium",
//                             fontSize: 16,
//                             color: AppConstants().ltDarkGrey,
//                           ),
//                         ),
//                         value: dropdownValue,
//                         items: const [
//                           DropdownMenuItem(
//                             child: Text("Ağır vasıta"),
//                             value: 1,
//                           ),
//                           DropdownMenuItem(
//                             child: Text("Hafif ticari"),
//                             value: 2,
//                           ),
//                           DropdownMenuItem(
//                             child: Text("Motor"),
//                             value: 3,
//                           ),
//                         ],
//                         onChanged: (int? dropDownValue) {
//                           setState(() {
//                             dropdownValue = dropDownValue;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   DummyBox15(),
//                   Container(
//                     width: Get.width * 0.8,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: AppConstants().ltWhite,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       child: DropdownButton(
//                         iconEnabledColor: AppConstants().ltDarkGrey,
//                         underline: SizedBox(),
//                         isExpanded: true,
//                         borderRadius: BorderRadius.circular(8),
//                         hint: Text(
//                           "Marka Seç",
//                           style: TextStyle(
//                             fontFamily: "Sfmedium",
//                             fontSize: 16,
//                             color: AppConstants().ltDarkGrey,
//                           ),
//                         ),
//                         value: brandValue,
//                         items: const [
//                           DropdownMenuItem(
//                             child: Text("Scania"),
//                             value: 1,
//                           ),
//                           DropdownMenuItem(
//                             child: Text("Mercedes"),
//                             value: 2,
//                           ),
//                           DropdownMenuItem(
//                             child: Text("Volvo"),
//                             value: 3,
//                           ),
//                           DropdownMenuItem(
//                             child: Text("Ford"),
//                             value: 4,
//                           ),
//                         ],
//                         onChanged: (int? brandvalue) {
//                           setState(() {
//                             brandValue = brandvalue;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   DummyBox15(),
//                   Container(
//                     width: Get.width * 0.8,
//                     height: 50,
//                     decoration: BoxDecoration(
//                       color: brandValue == null
//                           ? AppConstants().ltDarkGrey
//                           : AppConstants().ltWhite,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12.0),
//                       child: DropdownButton(
//                         iconEnabledColor: brandValue == null
//                             ? AppConstants().ltWhite.withOpacity(0.5)
//                             : AppConstants().ltDarkGrey,
//                         underline: SizedBox(),
//                         isExpanded: true,
//                         borderRadius: BorderRadius.circular(8),
//                         value: modelValue,
//                         hint: Text(
//                           "Model Seç",
//                           style: TextStyle(
//                             fontFamily: "Sfmedium",
//                             fontSize: 16,
//                             color: brandValue == null
//                                 ? AppConstants().ltWhite.withOpacity(0.5)
//                                 : AppConstants().ltDarkGrey,
//                           ),
//                         ),
//                         items: brandValue == null
//                             ? items
//                             : const [
//                                 DropdownMenuItem(
//                                   child: Text("2010"),
//                                   value: 1,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2011"),
//                                   value: 2,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2012"),
//                                   value: 3,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2013"),
//                                   value: 4,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2014"),
//                                   value: 5,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2015"),
//                                   value: 6,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2016"),
//                                   value: 7,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2017"),
//                                   value: 8,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2018"),
//                                   value: 9,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2019"),
//                                   value: 10,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2020"),
//                                   value: 11,
//                                 ),
//                                 DropdownMenuItem(
//                                   child: Text("2021"),
//                                   value: 12,
//                                 ),
//                               ],
//                         onChanged: (int? model) {
//                           setState(() {
//                             modelValue = model;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                   const DummyBox15(),
//                   CustomTextField(
//                     hintText: 'Plaka',
//                     controller: numberPlateController,
//                   ),
//                   const DummyBox15(),
//                   CustomTextField(
//                     hintText: 'Kapasite (Kg)',
//                     controller: capacityController,
//                   ),
//                   const DummyBox15(),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         "Araç kime ait?",
//                         style: TextStyle(
//                           fontFamily: "Sfsemidold",
//                           fontSize: 16,
//                           color: AppConstants().ltWhite,
//                         ),
//                       ),
//                       20.w.spaceX,
//                       Text(
//                         "Şahsi",
//                         style: TextStyle(
//                           fontFamily: "Sfsemidold",
//                           fontSize: 16,
//                           color: AppConstants().ltWhite,
//                         ),
//                       ),
//                       10.w.spaceX,
//                       SizedBox(
//                         width: 50,
//                         child: FlutterSwitch(
//                           inactiveToggleColor: Colors.white,
//                           inactiveColor: const Color(0xffDDDDDD),
//                           activeColor: const Color.fromARGB(255, 107, 221, 69),
//                           showOnOff: false,
//                           //activeText: 'on',
//                           //activeTextColor: const Color(0xff8AD96F),
//                           //inactiveText: 'off',
//                           //inactiveTextColor: AppConstants().ltDarkGrey,
//                           toggleSize: 28,
//                           padding: 2,
//                           borderRadius: 20,
//                           value: toggle,
//                           onToggle: (val) {
//                             setState(() {
//                               toggle = !toggle;
//                             });
//                           },
//                         ),
//                       ),
//                       10.w.spaceX,
//                       Text(
//                         "Şirket",
//                         style: TextStyle(
//                           fontFamily: "Sfsemidold",
//                           fontSize: 16,
//                           color: AppConstants().ltWhite,
//                         ),
//                       ),
//                     ],
//                   ),
//                   DummyBox15(),
//                   RedButton(
//                     text: 'Araç Ekle ve Devam Et',
//                     onpressed: () {
//                       if (mailController.text.isNotEmpty ||
//                           numberPlateController.text.isNotEmpty ||
//                           capacityController.text.isNotEmpty) {
//                         Get.offAndToNamed(NavigationConstants.mapPage);
//                       } else {
//                         Get.snackbar("Uyarı", "Lütfen tüm alanları doldurun!",
//                             backgroundColor: AppConstants().ltWhite);
//                       }
//                     },
//                   ),
//                   const DummyBox15(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
