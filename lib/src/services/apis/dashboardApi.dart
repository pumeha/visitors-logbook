import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;

import '../../providers/dashboard_provider.dart';
import '../../utils/myPreferences.dart';
import '../../utils/constants.dart';

class DashboardApi{


  Future<dynamic> dashBoardData(from,to) async{
    await EasyLoading.show(status: 'Loading',maskType: EasyLoadingMaskType.black);
    String? userid = await MyPreferences().getPreference('userid');

    try {
      final response = await http.post(Uri.parse('https://www.smarterwayltd.com/ams/api/visitors/rangeStatistics'),
          headers: {'Content-Type' : 'application/json'},
          body: jsonEncode({
            "userid":userid,
            "from":from,
            "to": to
          })).timeout(Duration(seconds: 5),onTimeout: (){
        throw TimeoutException('Connection has timed out. Please check your network or try again.');
      });
      if(response.statusCode == 200) {

        EasyLoading.showSuccess('Success!!');
        return response.body;
      }else {
        EasyLoading.showError(jsonDecode(response.body)['message']);
        return;
      }
    } on SocketException catch (_) {
      DashboardProvider().resetValues();
      EasyLoading.dismiss();
      EasyLoading.showError('No internet connection found');
      return;
    } catch (e){
      DashboardProvider().resetValues();
      EasyLoading.dismiss();
      EasyLoading.showError('Error : ${e.toString()}',duration: Duration(seconds: 5));
      return;
    }


  }

  Future<void> getData(from ,to ) async{
    await EasyLoading.show(status: 'Loading',maskType: EasyLoadingMaskType.black);
    String? userid = await MyPreferences().getPreference('userid');


    try {
      final response = await http.post(Uri.parse('https://www.smarterwayltd.com/ams/api/visitors'),
      headers: {'Content-Type' : 'application/json'},
      body: jsonEncode({
        "userid":userid,
        "from":from,
        "to": to,
      })).timeout(Duration(seconds: 5),onTimeout: (){
        throw TimeoutException('Timeout');
      });
      if(response.statusCode == 200) {
        String csv =  Constants().convertJsonToCsv(List<Map<String,dynamic>>.from(jsonDecode(response.body)['data']));

        String filename = 'from_'+from  + '_' + to;
        await Constants().saveCsvToFile(csv,filename);
        EasyLoading.showSuccess('Success!!');
      }else {
        EasyLoading.showError(jsonDecode(response.body)['message']);

      }
    } on SocketException catch (_) {
      EasyLoading.dismiss();
      EasyLoading.showError('No internet connection found');
    } catch (e){
      EasyLoading.dismiss();
      EasyLoading.showError('Error : ${e.toString()}',duration: Duration(seconds: 5));
    }


  }

  Future<dynamic> search(String userid,String name, String phonenumber, String status) async {
    Constants().load();
    String url = 'https://www.smarterwayltd.com/ams/api/visitors/search/${userid}.${name}.${phonenumber}.${status}';
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5),onTimeout: (){
        throw TimeoutException("Connection has timed out. Please check your network or try again.");
      });

      if(response.statusCode == 200){
        EasyLoading.showSuccess('Successfully');
        return response.body;
      }else{
        EasyLoading.showError(jsonDecode(response.body)['message']);
        return;
      }
    }on SocketException catch(_){
      EasyLoading.showError('No internet connection found');
      return;
    } catch (e) {
      EasyLoading.showError('Error : ${e.toString()}');
      return;
    }
  }

  Future<int> createUser(String userid,String firstname,String lastname, String phonenumber,String passcode,String role) async{
    String url = 'https://www.smarterwayltd.com/ams/api/users/add';
    try{
      final response = await http.post(Uri.parse(url),
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode({

          "lastname" : lastname,
          "firstname": firstname,
          "phonenumber" : phonenumber,
          "passcode" : passcode,
          "role" : role
        })).timeout(const Duration(seconds: 5),onTimeout: (){
        throw TimeoutException("Connection has timed out. Please check your network or try again.");
      });


      if(response.statusCode == 201){
        EasyLoading.showSuccess('Successful!');
        return 1;

      }else{
        EasyLoading.showError(jsonDecode(response.body)['message']);
        return 0;
      }

    }on SocketException catch(_){
      EasyLoading.showError('No internet connection found');
      return 0;
    }catch(e){
      EasyLoading.showError('Error : ${e.toString()}');
      return 0;
    }


  }

  Future<dynamic> getUsers(String userid) async {
    Constants().load();
    String url = 'https://www.smarterwayltd.com/ams/api/users/${userid}';
    try {
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 5),onTimeout: (){
        throw TimeoutException("Connection has timed out. Please check your network or try again.");
      });

      if(response.statusCode == 200){
        EasyLoading.showSuccess('Successfully');
        return response.body;
      }else{
        EasyLoading.showError(jsonDecode(response.body)['message']);
        return;
      }
    }on SocketException catch(_){
      EasyLoading.showError('No internet connection found');
      return;
    } catch (e) {
      EasyLoading.showError('Error : ${e.toString()}');
      return;
    }
  }

}