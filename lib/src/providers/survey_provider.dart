import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';
import '../utils/myPreferences.dart';

class SurveyProvider with ChangeNotifier{

  late Future<Map<String, dynamic>> todayData;
  List<bool>  satisfyvalue = [false,false,false,false,false];
  List<bool> yesNo = [false,false];
  TextEditingController noreasons = TextEditingController();
  late String _noreasons = noreasons.text;
  late bool editableForNoReasonsText = false;
  late int satisfyChoice = 7;
  late String _error = '';

  String get error => _error;

  set error(String value) {
    _error = value;
    notifyListeners();
  }



  void updateCheckBox(int index){
   if(yesNo[1] == true){
     for(int t = 0; t < satisfyvalue.length;t++){
       satisfyvalue[t] = t == index;
     }
     notifyListeners();
     satisfyChoice = index;
     noreasons.text = '';
   }
  }

  void updateCheckBoxYN(int index){
    if(index == 1)  editableForNoReasonsText = false;
    if(index == 0) editableForNoReasonsText = true;
    for(int t = 0; t < yesNo.length;t++){
      yesNo[t] = t == index;
    }
    notifyListeners();
  }

  void resetCheckBox(){
    for(int i = 0; i < satisfyvalue.length; i++){
      satisfyvalue[i] = false;
    }
    notifyListeners();
    satisfyChoice = 7;
  }

  void resetCheckBoxYN(){
    for(int i = 0; i < yesNo.length; i++){
      yesNo[i] = false;
      noreasons.text = '';
    }
    notifyListeners();
  }

  Future<void> submit(BuildContext context, String visitorid) async {

    error = '';
  String yesno  = '';
    if(yesNo[1] == true){
        yesno = 'yes';
        if(satisfyChoice == 7){
         error= 'Kindly select the level of satisfaction';
         return;
        }
        _noreasons = 'NA';
    }else if(yesNo[0] == true){
      yesno  = 'no';

      if(_noreasons.isEmpty){
         error = 'Kindly fill in the reasons';
       return;
      }
    }else{
      error = 'Invalid Inputs';
      return;
      }
   await signOutOfficial(context, visitorid,yesno,satisfyChoice.toString(),_noreasons);




    }



  Future<void> signOutOfficial(BuildContext context,String visitorid,
      String satisfied,String how_satisfied,String reasons) async {

   await Constants().load();

    if(visitorid.isEmpty){
     EasyLoading.dismiss();
     EasyLoading.showInfo('Valid input required ');
    }

    try {
      String url = 'https://www.smarterwayltd.com/ams/api/survey';
      String? userid = await MyPreferences().getPreference('userid');
      //data to send
      Map<String,String?> data = {
        "userid":  userid,
        "visitorid" : visitorid,
        "satisfied" : satisfied,
        "how_satisfied" : how_satisfied,
        "reasons" : reasons
      };

      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type' : 'application/json'},
          body: jsonEncode(data)).timeout(const Duration(seconds: 5),onTimeout: (){
        throw TimeoutException(Constants().timeOutMessage());
      });

      if(response.statusCode == 200){
        EasyLoading.dismiss();
        Navigator.pop(context);

      }else{

        error = jsonDecode(response.body)['message'];
        EasyLoading.showError(error);
      }
    }on SocketException catch(_){
      EasyLoading.dismiss();
      error = 'No internet connection found';
      EasyLoading.showError(error);

    } catch (e) {
      EasyLoading.dismiss();
      error = 'Error : ${e.toString()}';
      EasyLoading.showError(error);
    }



  }


  }


