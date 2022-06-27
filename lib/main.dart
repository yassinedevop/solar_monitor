import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:solar_monitor/screen/login_screen.dart';
import 'package:solar_monitor/screen/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Geofence.initialize();
  Geofence.requestPermissions();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar Monitor',
      initialRoute:
          FirebaseAuth.instance.currentUser != null ? '/main' : '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/main': (context) => MainScreen(),
      },
    );
  }
}
