import 'dart:convert';
import 'package:flutter/material.dart';

import '../services/apis/dashboardApi.dart';
import '../utils/constants.dart';
import '../utils/myPreferences.dart';

class UsersProvider with ChangeNotifier{

  TextEditingController firstname = TextEditingController();
  TextEditingController lastname = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController passcode = TextEditingController();
  late List<dynamic> usersdata = [];
  Future<int> addUser(String role) async{

    String f_name = firstname.text;
    String l_name = lastname.text;
    String p_number = phonenumber.text;
    String p_code = passcode.text;
    String? userid = await MyPreferences().getPreference('userid');

  await Constants().load();
 return  await DashboardApi().createUser(userid!, f_name,l_name ,p_number, p_code,role);
  }

  Future<void> getUsers() async{
    String? userid = await MyPreferences().getPreference('userid');
    final response = await DashboardApi().getUsers(userid!);
    if(response != null){
      List<dynamic> users = jsonDecode(response)['data'];
     usersdata = users;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstname.clear();
    lastname.clear();
    phonenumber.clear();
    passcode.clear();
  }

  clearTextFields(){
    firstname.clear();
    lastname.clear();
    phonenumber.clear();
    passcode.clear();
  }


}