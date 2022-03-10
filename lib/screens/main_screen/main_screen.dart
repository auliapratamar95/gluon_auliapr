import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gluon_flutter_test_auliapr/screens/main_screen/main_screen_controller.dart';
import 'package:gluon_flutter_test_auliapr/shared/palette.dart';
import 'package:gluon_flutter_test_auliapr/widgets/custom_textfield/custom_textfield.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  late final MainScreenController mainScreenController;

  _init(){
    Get.delete<MainScreenController>();
    mainScreenController = Get.put(MainScreenController());
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gluon Flutter Test')),
      backgroundColor: Palette.blueStatus,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomTextField(
          controller: mainScreenController.inputController,
          label: 'Username',
          labelStyle: const TextStyle(color: Palette.light),
          placeholder: 'Type here',
          prefixIcon: const Icon(Icons.person,color: Palette.gray,),
          onChanged: (val){},
        ),
      ),
    );
  }
}
