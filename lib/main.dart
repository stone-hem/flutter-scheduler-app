import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:scheduler/db/db_helper.dart';
import 'package:scheduler/screens/home.dart';
import 'package:scheduler/screens/theme.dart';
import 'package:scheduler/services/themeservices.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  //initialize get storage at the entry point of the application
  WidgetsFlutterBinding.ensureInitialized(); //ensure initialization first
  await DbHelper.initDB();//ensure the database is initialized
  await GetStorage.init(); //await must be used in an async function
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Schedular',
      debugShowCheckedModeBanner: false,
      //calling the class name to access the static variable
      theme: Themes.light,
      darkTheme: Themes.dark,
      //theme mode changing
      themeMode: ThemeService().theme,

      home: const Home(),
    );
  }
}
