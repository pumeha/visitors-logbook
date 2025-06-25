import 'package:flutter/material.dart';

class landingPage extends StatefulWidget {
  const landingPage({super.key});

  @override
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: Colors.green)),
      child: Scaffold(
        body: Center(child:  SizedBox(width: 500,height: 500,
          child: Image.asset('images/splashScreenImage.jpg'),)),
        ),
    );
  }
}



