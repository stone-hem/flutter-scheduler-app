import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/screens/theme.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const InputField({
    Key? key,
    required this.title,
    required this.hint,
     this.controller,
    this.widget
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:const EdgeInsets.only(top: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleStyle,
          ),
          Container(
            height: 52,
            margin: const EdgeInsets.only(top: 8.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    //if there is a widget, then set it to read only
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode?Colors.grey[100]:Colors.grey[700],
                    controller: controller,
                    style: subTitleStyle,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: inputTextStyle,
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.colorScheme.background,
                          width: 1.0
                        )
                        ),
                        enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: context.theme.colorScheme.background,
                          width: 1.0
                        )
                        ),
                    )
                  )
                  ),
                  //check if another widget exists in the row
                  //this is the reason why expanded widget is used
                  widget==null?Container():Container(child: widget,)
              ],
            ),
          )

          ]),
    );
  }
}
