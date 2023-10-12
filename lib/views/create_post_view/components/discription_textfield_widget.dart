import 'dart:developer';

import 'package:fillogo/export.dart';
import 'package:fillogo/views/create_post_view/components/create_post_page_controller.dart';

// ignore: must_be_immutable
class DiscriptionTextFieldWidget extends StatelessWidget {
  DiscriptionTextFieldWidget(
      {super.key,
      required this.discriptionContent,
      required this.discriptionTextController});

  final String discriptionContent;
  TextEditingController discriptionTextController;

  CreatePostPageController discriptionController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: discriptionTextController,
      onEditingComplete: () {
        discriptionController
            .changeDiscriptionContent(discriptionTextController.text);
        discriptionController.changeHaveDiscription(1);
      },
      onFieldSubmitted: (value) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      // onChanged: (value) {
      //   // print(discriptionTextController.text);
      //   // // log("Hey");
      // },
      // onSubmitted: (value) async {
      //   discriptionController.discriptionContent.value =
      //       discriptionTextController.text;
      // },
      // onTapOutside: (event) async {
      //   CreatePostPageControllerDisCont().discriptionContent =
      //       discriptionTextController.text;
      //   discriptionController
      //       .changeDiscriptionContent(discriptionTextController.text);
      //   print("111111  " + discriptionController.discriptionContent.value);
      //   print("222222  " + discriptionTextController.text);
      //   print(
      //       "333333  " + CreatePostPageControllerDisCont().discriptionContent);
      //   //discriptionTextController.text = '';
      //   // discriptionController.changeDiscriptionContent(
      //   //   discriptionContent,
      //   // );
      // },
      textCapitalization: TextCapitalization.none,
      autofocus: false,
      keyboardType: TextInputType.text,
      maxLines: null,
      obscureText: false,
      maxLength: 1000,
      cursorColor: AppConstants().ltMainRed,
      expands: false,

      textDirection: TextDirection.ltr,
      style: TextStyle(
        fontSize: 16.sp,
        fontFamily: 'Sfregular',
        color: AppConstants().ltLogoGrey,
      ),
      decoration: InputDecoration(
        counterText: '',
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
        ),
        hintText: 'Ne düşünüyorsunuz',
        hintStyle: TextStyle(
          fontSize: 16.sp,
          fontFamily: 'Sflight',
          color: AppConstants().ltDarkGrey,
        ),
      ),
    );
  }
}
