import 'package:attendance_system/src/screens/LandingPage.dart';
import 'package:attendance_system/src/screens/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  // Initialize window manager
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(500, 500),
      size: Size(500, 500),
      center: true,
      title: 'Visitor\'s Logbook'
  );

  windowManager.waitUntilReadyToShow(windowOptions,() async{
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setAsFrameless();
    await windowManager.setResizable(false);
  });




  runApp(Home());

  Future.delayed(const Duration(seconds: 5),(){
    showLogin();
  });



}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(home: landingPage(),debugShowCheckedModeBanner: false,
 );
  }
}
