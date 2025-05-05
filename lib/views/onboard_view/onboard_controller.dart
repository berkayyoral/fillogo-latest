import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardController extends GetxController {
  late PageController pageController;
  RxInt currentPage = 0.obs;
  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0, viewportFraction: 1);
    pageController.addListener(() {
      currentPage.value = pageController.page!.round();
    });
  }

  void previousPage() {
    currentPage.value--;
    pageController.jumpToPage(currentPage.value);
  }

  void nextPage() {
    currentPage.value++;
    pageController.jumpToPage(currentPage.value);
  }
}
