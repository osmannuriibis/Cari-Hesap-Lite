import 'package:flutter/material.dart';

class OnBoardingViewModel extends ChangeNotifier {
  var list = <OnboardModel>[
    OnboardModel(
        "Cariler",
        "Müşterileriniz ile olan işlemlerinizi hep güncel tutun.",
        "assets/svg/customer.svg"),
    OnboardModel("Stok Takip", "Stok hareketlerini takip edin",
        "assets/svg/product.svg"),
    OnboardModel(
        "Raporlama",
        "Alış Satış işlemlerinde gözünüzden birşey kaçmasın",
        "assets/svg/report.svg"),
  ];

  int index = 0;

  OnBoardingViewModel() {}

  void changeIndex(int value) {
    index = value;
    notifyListeners();
  }
}

class OnboardModel {
  final String title;
  final String description;
  final String imagePath;

  OnboardModel(this.title, this.description, this.imagePath);
}
