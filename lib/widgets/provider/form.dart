import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier{
    final TextEditingController _controllerName = TextEditingController();
  
  final TextEditingController _controllerAdult = TextEditingController();
  final TextEditingController _controllerSenior = TextEditingController();
  final TextEditingController _controllerChild = TextEditingController();

  final TextEditingController _controllerUmbrella = TextEditingController();
  final TextEditingController _controllerCottage = TextEditingController();
  final TextEditingController _controllerTent = TextEditingController();


  void clearForm() {
    debugPrint("It's going to the clearForm function!");
    _controllerName.clear();
    _controllerAdult.clear();
    _controllerSenior.clear();
    _controllerChild.clear();
    _controllerUmbrella.clear();
    _controllerCottage.clear();
    _controllerTent.clear();
  }
}