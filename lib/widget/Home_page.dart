// import 'dart:js';

// import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_app1/widget/dashboard.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  void logOut() async {
    await FirebaseAuth.instance.signOut();

    // if (context.mounted) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => dashboard()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple,
        appBar: AppBar(
          title: Text("NIT WARRANGL"),
          actions: [
            IconButton(
                onPressed: () {
                  logOut();
                },
                icon: Icon(Icons.exit_to_app)),
          ],
        ),
        body: ClassScheduler());
  }
}

class ClassScheduler extends StatefulWidget {
  @override
  _ClassSchedulerState createState() => _ClassSchedulerState();
}

class _ClassSchedulerState extends State<ClassScheduler> {
  // Map<String, List<String>> mcaTimetable = {};
  final Map<String, List<String>> mcaTimetable = {
    'Monday': [
      '9:00 AM - 10:30 AM: Math',
      '11:00 AM - 12:30 PM: Computer Science',
      '1:30 PM - 3:00 PM: English',
    ],
    'Tuesday': [
      '9:00 AM - 10:30 AM: Physics',
      '11:00 AM - 12:30 PM: Chemistry',
      '1:30 PM - 3:00 PM: Biology',
    ],
    'Wednesday': [
      '9:00 AM - 10:30 AM: History',
      '11:00 AM - 12:30 PM: Geography',
      '1:30 PM - 3:00 PM: Civics',
    ],
    'Thursday': [
      '9:00 AM - 10:30 AM: Economics',
      '11:00 AM - 12:30 PM: Sociology',
      '1:30 PM - 3:00 PM: Psychology',
    ],
    'Friday': [
      '9:00 AM - 10:30 AM: Physical Education',
      '11:00 AM - 12:30 PM: Art',
      '1:30 PM - 3:00 PM: Music',
    ],
  };

  DateTime? _newClassDate;
  TimeOfDay? _newClassTime;

  // Fiebase
  Future updateTimeTable() async {
    final data = await FirebaseFirestore.instance
        .collection('teacher')
        .doc('xyz')
        .set(mcaTimetable);
    // final data = await FirebaseFirestore.instance.collection('teacher').get();
    // data.docs.forEach((element) {
    //   print(element.id);
    // });
  }

  Future getTimeTable() async {
    final data =
        await FirebaseFirestore.instance.collection('teacher').doc('xyz').get();
    print(data.data());
  }

  //
  @override
  Widget build(BuildContext context) {
    getTimeTable();
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple[200]!,
              Colors.deepPurple[300]!,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _showTimetable(context);
                },
                child: Text('Show Timetable'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showRescheduleDialog(context);
                },
                child: Text('Reschedule Class'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  print('Cancel button pressed');
                  // Implement cancel class logic here
                },
                child: Text('Cancel Class'),
              ),
            ],
          ),
        ),
    );
  }

  void _showTimetable(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('MCA Timetable'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildTimetable(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showRescheduleDialog(BuildContext context) async {
    DateTime? pickedDate = await _selectDate(context);
    if (pickedDate != null) {
      TimeOfDay? pickedTime = await _selectTime(context);
      if (pickedTime != null) {
        setState(() {
          _newClassDate = pickedDate;
          _newClassTime = pickedTime;
        });
        _submitNewClassDateTime(context);
      }
    }
  }

  Future<DateTime?> _selectDate(BuildContext context) {
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
  }

  Future<TimeOfDay?> _selectTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  void _submitNewClassDateTime(BuildContext context) {
    if (_newClassDate != null && _newClassTime != null) {
      print('New class date: $_newClassDate, time: $_newClassTime');
      Navigator.of(context).pop();
      // Implement logic to notify students about the new class date and time
    } else {
      // Handle case when date or time is not selected
    }
  }

  List<Widget> _buildTimetable() {
    List<Widget> timetableWidgets = [];
    mcaTimetable.forEach((day, classes) {
      timetableWidgets.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              day,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: classes.map((classTime) {
                return ListTile(
                  leading: Icon(Icons.event),
                  title: Text(classTime),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
          ],
        ),
      );
    });
    return timetableWidgets;
  }
}
