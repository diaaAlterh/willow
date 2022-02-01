import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:willow/ui/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Willow Care',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'SFProText',
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}