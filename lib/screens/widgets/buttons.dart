import 'package:flutter/material.dart';
import 'package:scheduler/screens/theme.dart';
import 'package:get/get.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function onTap;
  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //creating a clickable button using gesture detector
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Get.isDarkMode?Themes.blackColor:Themes.mainColor,
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
