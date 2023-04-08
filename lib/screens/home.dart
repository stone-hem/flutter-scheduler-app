import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/controllers/task_controller.dart';
import 'package:scheduler/models/task.dart';
import 'package:scheduler/screens/add_task_page.dart';
import 'package:scheduler/screens/theme.dart';
import 'package:scheduler/screens/widgets/buttons.dart';
import 'package:scheduler/services/notifysevices.dart';
import 'package:scheduler/services/themeservices.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

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
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      //customized application bar
      appBar: _appBar(),
      body: Column(
        children: [_addTaskBar(), _datePicker(), _displayTasks(width, height)],
      ),
    );
  }

  _displayTasks(width, height) {
    return Expanded(child: Obx(() {
      return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index) {
            Task task = _taskController.taskList[index];
            print(task.toJson());
            if (task.repeat == 'Daily') {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                        child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task, height);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Themes.cardThree,
                                borderRadius: BorderRadius.circular(16)),
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(20),
                            height: 100,
                            width: width * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title.toString(),
                                      style: GoogleFonts.lato(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Themes.whiteColor),
                                    ),
                                    Text(
                                      task.note.toString(),
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Themes.whiteColor),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          task.startTime.toString(),
                                          style: GoogleFonts.lato(
                                              color: Themes.whiteColor),
                                        ),
                                        Text(
                                          " to ${task.endTime}",
                                          style: GoogleFonts.lato(
                                              color: Themes.whiteColor),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                _getStatus(task.isCompleted)
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                  ));
            }
            if (task.date == DateFormat.yMd().format(_selectedDate)) {
              return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                        child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(context, task, height);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Themes.cardThree,
                                borderRadius: BorderRadius.circular(16)),
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(20),
                            height: 100,
                            width: width * 0.85,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      task.title.toString(),
                                      style: GoogleFonts.lato(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                          color: Themes.whiteColor),
                                    ),
                                    Text(
                                      task.note.toString(),
                                      style: GoogleFonts.lato(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Themes.whiteColor),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          task.startTime.toString(),
                                          style: GoogleFonts.lato(
                                              color: Themes.whiteColor),
                                        ),
                                        Text(
                                          " to ${task.endTime}",
                                          style: GoogleFonts.lato(
                                              color: Themes.whiteColor),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                _getStatus(task.isCompleted)
                              ],
                            ),
                          ),
                        )
                      ],
                    )),
                  ));
            } else {
              return Container();
            }
          });
    }));
  }

  _showBottomSheet(BuildContext context, Task task, height) {
    Get.bottomSheet(Container(
      color: Get.isDarkMode ? Themes.bgDarkScaffold : Themes.whiteColor,
      padding: const EdgeInsets.only(top: 4),
      height: task.isCompleted == 1 ? height * 0.24 : height * 0.32,
      child: Column(
        children: [
          Container(
            height: 6,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Get.isDarkMode ? Themes.blackColor : Themes.mainColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          task.isCompleted == 1
              ? Container()
              : _bottomSheetButton(
                  label: "Tick Completed",
                  onTap: () {
                    _taskController.tickTask(task.id!);
                    _taskController.getTasks();
                    Get.back();
                  },
                  clr: Themes.mainColor,
                  context: context),
          const SizedBox(
            height: 10,
          ),
          _bottomSheetButton(
              label: "Remove Task",
              onTap: () {
                _taskController.remove(task);
                _taskController.getTasks();
                Get.back();
              },
              clr: Colors.red.shade400,
              context: context),
          const SizedBox(
            height: 10,
          ),
          _bottomSheetButton(
              label: "Close",
              isClose: true,
              clr: Colors.white,
              context: context,
              onTap: () {
                Get.back();
              }),
        ],
      ),
    ));
  }

  _bottomSheetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey
                    : Colors.white
                : clr,
            border: Border.all(width: 2, color: isClose ? Colors.grey : clr),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(label,
                style: isClose
                    ? titleStyle
                    : titleStyle.copyWith(color: Colors.white))),
      ),
    );
  }

  _getStatus(status) {
    if (status == 0) {
      return Icon(
        Icons.question_mark,
        color: Colors.red.shade100,
      );
    } else {
      return Icon(
        Icons.done,
        color: Colors.green.shade100,
      );
    }
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
          setState(() {
            _selectedDate = date;
          });
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
