import 'package:flutter/material.dart';

class OnboardModels {
  String imgAsset;
  String title;
  String description;

  bool isJukkaLogo;

  OnboardModels(
      {required this.title,
      required this.description,
      required this.imgAsset,
      required this.isJukkaLogo});
}

List<OnboardModels> onboardModels = [
  OnboardModels(
    title: "FilloGo",
    isJukkaLogo: true,
    description:
        "FilloGo ile beraber yola çıkan veya çıkacak olan arkadaşlarınızı görebilirsiniz. Gönderiler paylaşabilirsiniz.",
    imgAsset: "assets/images/2-1.png",
  ),
  OnboardModels(
    isJukkaLogo: true,
    title: "FilloGo",
    description:
        "Rotadaki arkadaşlarınızı görebilir, onlarla iletişime geçebilirsiniz. Gittiğiniz yerlerden paylaşım yapabilir, anılar oluşturabilirsiniz.",
    imgAsset: "assets/images/3-1.png",
  ),
  OnboardModels(
    isJukkaLogo: true,
    title: "FilloGo",
    description:
        "Şimdi bu maceranın bir parçası ol ve uygulamamıza katılarak arkadaşlarınla ve diğer sürücülerle bağlantı kur.",
    imgAsset: "assets/images/4-1.png",
  ),
];
