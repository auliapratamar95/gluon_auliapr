import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MainScreenController extends GetxController {

  late TextEditingController inputController;

  @override
  void onInit() {
    inputController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    inputController.dispose();
    super.onClose();
  }
}