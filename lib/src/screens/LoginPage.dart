
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import '../providers/dashboard_provider.dart';
import '../providers/login_provider.dart';
import '../providers/search_provider.dart';
import '../providers/survey_provider.dart';
import '../providers/users_provider.dart';
import '../providers/visitor_provider.dart';


Future<void> showLogin() async {
  WindowOptions windowOptions = const WindowOptions(
      minimumSize: Size(800, 700),
      size: Size(800, 700),
      center: true,
      title: 'Visitor\'s Logbook'
  );

  windowManager.waitUntilReadyToShow(windowOptions,() async{
    await windowManager.setTitleBarStyle(TitleBarStyle.normal);
    await windowManager.setResizable(true);
    await windowManager.setClosable(true);
    await windowManager.center(animate: true);
  });


  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_)=> LoginProvider()),
      ChangeNotifierProvider(create: (_)=> VisitorProvider()),
      ChangeNotifierProvider(create: (_) => SurveyProvider()),
      ChangeNotifierProvider(create: (_) => DashboardProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
      ChangeNotifierProvider(create: (_)=> UsersProvider())
    ],child: const MyMainApp(),));
}

class MyMainApp extends StatelessWidget {
  const MyMainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(home: loginPage(),debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
    );
  }
}


class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {

  bool _showpassword = true;
  List<bool> ischecked = [false,false,false];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordControlller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    EasyLoading.addStatusCallback((status){
      if(status == EasyLoadingStatus.dismiss){
        _timer?.cancel();
      }
    });}

  @override
  Widget build(BuildContext context) {
    return  Theme(
        data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: Colors.green),),
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('images/background.jpg'),
            fit: BoxFit.cover)),
            child: Center(
              child: Container( width: 400, height: 500,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Form(key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(child: Image.asset('images/img.png'),height: 60,width: 60,),
                     const SizedBox(height: 24,),
                      Text('Login',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold,color: Colors.green[900]),),

                      const SizedBox(height: 24,),
                      SizedBox(
                        width: 300,
                        child: TextFormField(decoration: const InputDecoration(border: OutlineInputBorder(),
                            labelText: 'Phone number', labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2)),
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)),
                        hintText: '070xxxxxxxx',
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2),)),
                          cursorColor: Colors.green[900],
                        controller: context.watch<LoginProvider>().phonenumber,maxLength: 11,
                        validator: (val) => val!.length != 11 ? 'Invalid Phone number' : null,keyboardType: TextInputType.phone,),
                      ),
                      const SizedBox(height: 12,),
                      SizedBox( width: 300,
                        child: TextFormField( decoration: InputDecoration(border: const OutlineInputBorder(),labelText:'Passcode',
                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black,width: 2)),
                        errorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2)),
                        focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red,width: 2)),
                        suffixIcon: IconButton(onPressed: (){
                         setState(() {
                          _showpassword = !_showpassword;
                         });
                        }, icon: Icon(_showpassword ? Icons.visibility : Icons.visibility_off)),
                          labelStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        cursorColor: Colors.green[900],controller: context.watch<LoginProvider>().passcode,obscureText: _showpassword,
                        validator: (val)=> val!.length != 5 ? 'Invalid passcode' : null,
                        ),
                      ),
                      const SizedBox(height: 12,),
                      //sol
                      const SizedBox(height: 12,),// ving problem using tech(SPUT)
                      ElevatedButton(onPressed: () async {
                          if(_formKey.currentState!.validate()){
                            _timer?.cancel();
                            await EasyLoading.show(
                              status: 'loading...',
                              maskType: EasyLoadingMaskType.black,
                            );
                            context.read<LoginProvider>().sendRequest(context);
                          }
                      },child: const Padding( padding: EdgeInsets.all(8.0),
                        child: Text('Proceed',style: TextStyle(color: Colors.white),),),
                        style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green[900]),),),
                      // TextButton(onPressed: () async {
                      //   bool? value = await Constants().getNetworkStatus();
                      //   print( value);
                      // }, child: Text('Check network'))


                    ],
                  ),
                ),
              ),
            ),
          ),
          backgroundColor: Colors.white,
        ));

  }
}

