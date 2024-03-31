import 'package:flutter/material.dart';
import 'package:my_app1/utils/My_Routes.dart';
import 'package:my_app1/widget/Home_page.dart';
import 'package:my_app1/widget/login_page.dart';
import 'package:my_app1/widget/class2.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.cyan),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      // home: CounterScreen(),
      routes: {
        "/":(context)=>login(),
        MyRoutes.loginRoute:(content)=>login(),
        MyRoutes.homeRoute:(content)=>home(),
        // "/login":(content)=>login(),
        // "/home":(content)=>home(),
      },
    );
  }
}

// class CounterScreen extends StatefulWidget {
//   @override
//   _CounterScreenState createState() => _CounterScreenState();
// }
//
// class _CounterScreenState extends State<CounterScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//             child: Text('Teacher login')),
//         backgroundColor: Colors.grey,
//       ),
//       body:login(),
//
//
//     );
//   }
// }
