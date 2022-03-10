import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class CustomTextFieldController extends GetxController {

  final GlobalKey toolTipKey = GlobalKey();

  RxBool isInputValid = true.obs;

  handleOnChanged(String? value) {
    dynamic _toolTip = toolTipKey.currentState;
    if (value == null || value.isEmpty){
      isInputValid.value = true;
      _toolTip.deactivate();
    } else if (!value.isNull || value.isEmpty){
      isInputValid.value = false;
      _toolTip.activate();
      _toolTip.ensureTooltipVisible();
      vibrate();
    }
  }

  vibrate() async {
    if (await Vibration.hasVibrator() ?? false) {
      Vibration.vibrate(duration: 50,amplitude: 200);
    }
  }
}