import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

class ThemeService {
  //get storage will save values in a key pair just like json format
  //box is the variable where we want to save our boolean status
  final _box = GetStorage();
  //any random string name to store a value
  final _key = 'isDark';
  //method to save the state
  _saveThemeToBox(bool isDark) => _box.write(_key, isDark);
  //create an arrow function to return boolean
  //we are reading the value of the key using the read method
  //if there is a value return the value as true else false(- value)
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  //if true use dark else light
  //keeping in mind that there is no value initially so the light will be returned
  //call theme from the main file
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;
//function to help change the theme mode dynamically
  void switchTheme() {
    //calling the theme mode
    //if true the use light else dark
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    //save the theme state
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
