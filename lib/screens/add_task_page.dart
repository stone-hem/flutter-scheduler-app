import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/screens/theme.dart';
import 'package:scheduler/screens/widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  String _endTime = "9:30 PM";
  String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  int _selectedRemind = 5;
  //a dropdown list
  List<int> remindList = [
    5,
    10,
    15,
    20,
  ];

  String _selectedRepeat = "None";
  //a dropdown list
  List<String> repeatList = ["None", "Daily", "weekly", "monthly"];

  int _selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.colorScheme.primary,
      appBar: _appBar(),
      body: SingleChildScrollView(
          padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            children: [
              Text(
                "Add Task",
                style: headingStyle,
              ),
              InputField(title: "Title", hint: "Enter your task's title"),
              InputField(title: "Note", hint: "Enter your task's notes"),
              InputField(
                title: "Date",
                hint: DateFormat.yMd().format(_selectedDate),
                widget: IconButton(
                    icon: Icon(Icons.calendar_today_outlined),
                    onPressed: () {
                      _getDateFromUser();
                    }),
              ),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      title: "Start date",
                      hint: _startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getUserTime(isStartTime: true);
                        },
                        icon: Icon(Icons.access_time_rounded),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InputField(
                      title: "End date",
                      hint: _endTime,
                      widget: IconButton(
                        onPressed: () {
                          _getUserTime(isStartTime: false);
                        },
                        icon: Icon(Icons.access_time_rounded),
                      ),
                    ),
                  )
                ],
              ),
              InputField(
                title: "Remind",
                hint: "$_selectedRemind minutes early",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: inputTextStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>((int value) {
                    return DropdownMenuItem<String>(
                        value: value.toString(), child: Text(value.toString()));
                  }).toList(),
                ),
              ),
              InputField(
                title: "Repeat",
                hint: "$_selectedRepeat",
                widget: DropdownButton(
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  style: inputTextStyle,
                  underline: Container(
                    height: 0,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRepeat = newValue!;
                    });
                  },
                  items:
                      repeatList.map<DropdownMenuItem<String>>((String? value) {
                    return DropdownMenuItem<String>(
                        value: value, child: Text(value!));
                  }).toList(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Color",
                        style: titleStyle,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Wrap(
                          children: List<Widget>.generate(3, (int index) {
                        return GestureDetector(
                          onTap: () {
                            _selectedColor = index;
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              radius: 14,
                              backgroundColor: index == 0
                                  ? Themes.cardOne
                                  : index == 1
                                      ? Themes.cardTwo
                                      : Themes.cardThree,
                                      child:const Icon(Icons.done,
                                      color: Colors.white,
                                      size: 16,
                                      ) ,
                            ),
                          ),
                        );
                      }))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
     
    );
  }

  _appBar() {
    //you must return the original application bar
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      //leading puts things at the beginning of the app bar
      //gesture detector constructor enables a click and  change
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        //icon to toggle
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      //actions tales a list and positions on the left side
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/profile.jpg'),
        ),
        //creates 20px distance from the left
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

//the date picker function to pick the date for the task
  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2120));
    if (_pickerDate != null) {
      setState(() {
        _selectedDate = _pickerDate;
      });
    } else {
      print("no date");
    }
  }

  //a function to get the time picker for the user to select
  _getUserTime({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    String _formattedTime = _pickedTime.format(context);
    if (_pickedTime == null) {
      print("time null");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formattedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formattedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }
}
