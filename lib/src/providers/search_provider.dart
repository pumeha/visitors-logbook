import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../services/apis/dashboardApi.dart';
import '../utils/myPreferences.dart';

class SearchProvider with ChangeNotifier{

  TextEditingController searchInput = TextEditingController();
  List<dynamic>? _data;

  List<dynamic>? get data => _data;

  set data(List<dynamic>? value) {
    _data = value;
  }
  Future<void> searchVisitor(String status) async{

    String value = searchInput.text;
    if(status != '1' && status != '0'){
      EasyLoading.showError('Select search type');
      return;
    }
    if(value.isEmpty){
      EasyLoading.showError('Enter the search value');
      return;
    }

    String name = '';
    String phonenumber = '';

    if(status == '1'){
      name = value;
      phonenumber = '09011345678';
    }
    if(status == '0'){
      phonenumber = value;
      name = 'test';
      if(value.length != 11 && int.parse(value) * 1 > 1) {
        EasyLoading.showError('Invalid Phone number');
        return;
      }
    }

    String? userid = await MyPreferences().getPreference('userid');
    if(name.isNotEmpty && phonenumber.isNotEmpty && status.isNotEmpty) {
      dynamic response = await DashboardApi().search(userid!, name, phonenumber,status);
      if(response != null) {
        List<dynamic> data = jsonDecode(response)['data'];
        this.data = data;

      }
    }
    notifyListeners();
  }
}



