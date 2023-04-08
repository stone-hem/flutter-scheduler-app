import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/controlllers/task_controller.dart';
import 'package:scheduler/db/db_helper.dart';
import 'package:scheduler/screens/add_task_page.dart';
import 'package:scheduler/screens/theme.dart';
import 'package:scheduler/screens/widgets/buttons.dart';
import 'package:scheduler/services/notifysevices.dart';
import 'package:scheduler/services/themeservices.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _taskController = Get.put(TaskController());

  DateTime _selectedDate = DateTime.now();

  var notifier;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifier = Notifier();
    notifier.initializeNotification();
    notifier.requestIOSPermissions();
    _taskController.getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //customized application bar
      appBar: _appBar(),
      body: Column(
        children: [_addTaskBar(), _datePicker(), _displayTasks()],
      ),
    );
  }

  _displayTasks() {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                _taskController.remove(_taskController.taskList[index].id);
              },
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: 100,
                height: 50,
                color: Themes.cardOne,
                child: Text(
                  _taskController.taskList[index].title.toString(),
                ),
              ),
            );
          });
    }));
  }

  _datePicker() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Get.isDarkMode ? Themes.blackColor : Themes.mainColor,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        dayTextStyle: GoogleFonts.lato(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey),
        monthTextStyle: GoogleFonts.lato(
            fontSize: 16, fontWeight: FontWeight.w600, color: Colors.blueGrey),
        onDateChange: (date) {
          _selectedDate = date;
        },
      ),
    );
  }

//this is the top task bar function
  _addTaskBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMd().format(DateTime.now()),
                  style: subHeadingStyle),
              Text("Today", style: headingStyle)
            ],
          ),
          MyButton(
              label: "+ Add Task",
              onTap: () async {
                await Get.to(() => const AddTaskPage());
                _taskController.getTasks();
              })
        ],
      ),
    );
  }

//creating a customized app bar
  _appBar() {
    //you must return the original application bar
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.colorScheme.background,
      //leading puts things at the beginning of the app bar
      //gesture detector constructor enables a click and  change
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifier.displayNotification(
              title: "Theme changed",
              body: Get.isDarkMode
                  ? "Light mode activated"
                  : "Dark mode activated");
          notifier.scheduledNotification();
        },
        //icon to toggle
        child: Icon(
          Get.isDarkMode ? Icons.toggle_on : Icons.toggle_off,
          size: 30,
          color: Get.isDarkMode ? Colors.white : Themes.mainColor,
        ),
      ),
      //actions tales a list and positions on the right side
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/profile.jpg'),
        ),
        //creates 20px distance from the right
        SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
