import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../screens/admin/AdminHomePage.dart';

import '../screens/receptionist/ReceptionistHomePage.dart';
import '../utils/constants.dart';
import '../utils/myPreferences.dart';

class LoginProvider with ChangeNotifier{
TextEditingController phonenumber = TextEditingController();
TextEditingController passcode = TextEditingController();

  Future<void> sendRequest(BuildContext context) async {

    try {
      final response = await http.post(Uri.parse('https://www.smarterwayltd.com/ams/api/users/login'),
          headers: {'Content-Type' : 'application/json'},
          body: jsonEncode({
            "phonenumber" : Constants().sanitizeInputs(phonenumber.text),
            "passcode" : Constants().sanitizeInputs(passcode.text)
          })).timeout(const Duration(seconds : 5),onTimeout: (){
        throw TimeoutException("Connection has timed out. Please check your network or try again.");
      });

      if (response.statusCode == 200) {
       clearFields();
        EasyLoading.dismiss();
        dynamic data = jsonDecode(response.body)['data'];
        String? role = data['role'];
        MyPreferences().setPreference('userid', data['userid']);
          if(role == "receptionist") {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const receptionistHomePage()));
          } else if(role == "admin")
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminHomePage()));

      } else {
        EasyLoading.dismiss();
        EasyLoading.showError('Request failed: ${jsonDecode(response.body)['message']}.');
      }
    }on SocketException catch(_){
      EasyLoading.dismiss();
      EasyLoading.showError('No internet connection found');
    } catch (e) {
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error : ${e.toString()}')));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phonenumber.dispose();
    passcode.dispose();
  }

  void clearFields(){
    phonenumber.clear();
    passcode.clear();
  }

}