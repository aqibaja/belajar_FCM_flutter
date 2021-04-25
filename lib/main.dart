import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _firebaseMessaging;

  getNotifikasiCart() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.subscribeToTopic("topicsTalk");
    _firebaseMessaging.configure(
        // ketika didalam aplikasi
        onMessage: (Map<String, dynamic> message) async {
          String title = "${message['notification']['title']}";
          print(title);
          if (title == "fail") {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: "${message['notification']['body']}",
              ),
            );
          } else if (title == "success") {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: "${message['notification']['body']}",
              ),
            );
          } else if (title == "info") {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: "${message['notification']['body']}",
              ),
            );
          }
        },
        //ketika app tertutup
        onLaunch: (Map<String, dynamic> message) async {},

        //ketika app berjalan di background
        onResume: (Map<String, dynamic> message) async {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Notif Success")),
              ElevatedButton(onPressed: () {}, child: Text("Notif Fail")),
              ElevatedButton(onPressed: () {}, child: Text("Notif Info")),
            ],
          ),
        ),
      ),
    );
  }
}
