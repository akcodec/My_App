import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app1/widget/Home_page.dart';
import 'package:my_app1/widget/dashboard.dart';
import 'package:my_app1/widget/login_page.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(primarySwatch: Colors.cyan),
      home:(FirebaseAuth.instance.currentUser !=null)?home():dashboard(),
      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      // home: CounterScreen(),
      // routes: {
      //   "/":(context)=>dashboard(),
      //   "/login":(content)=>login(),
      //   "/home":(content)=>home(),
      // },
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
