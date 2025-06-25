import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../utils/myPreferences.dart';

class VisitorProvider with ChangeNotifier{
  List<bool>  satisfyvalue = [false,false,false,false,false];

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  TextEditingController whoToSeeController = TextEditingController();
  TextEditingController tagNoController = TextEditingController();
  late String floor = '';
  late String total = '0';
  late int inn = 0;
  late int out = 0;
  late int contract  = 0;
  late int meeting = 0;
  late int research = 0;
  late int non = 0;
  late int technical = 0;

  late int first_inn = 0;
  late int first_out = 0;
  late int second_inn = 0;
  late int second_out = 0;
  late int third_inn = 0;
  late int third_out = 0;
  late int fourth_inn = 0;
  late int fourth_out = 0;
  late int fifth_inn = 0;
  late int fifth_out = 0;
  late int five = 0;
  late int four = 0;
  late int three = 0;
  late int two = 0;
  late int one = 0;



  void resetValues(){
    inn = 0;
    out = 0;
    contract = 0;
    meeting = 0;
    research = 0;
    non = 0 ;
    technical = 0;
    first_inn = 0;
    first_out = 0;
    second_inn = 0;
    second_out = 0;
    third_inn = 0;
    third_out = 0;
    fourth_inn = 0;
    fourth_out  = 0;
     fifth_inn = 0;
     fifth_out = 0;
     five = 0; four = 0;three = 0; two = 0; one = 0;
  }

  Future<void> submit(BuildContext context) async {
    Constants().load();

      if(checkInputs().isNotEmpty){
        EasyLoading.dismiss();
       customSnackBar(context, 'Valid input(s) required for ${checkInputs().join(',')}');
        return;
      }

     try {
       String url = 'https://www.smarterwayltd.com/ams/api/visitors/add';
        String? userid = await MyPreferences().getPreference('userid');
        //data to send
           Map<String,String?> data = {
        "fullname" : Constants().sanitizeInputs(nameController.text),
        "address" : Constants().sanitizeInputs(addressController.text),
        "phonenumber" : Constants().sanitizeInputs(phoneController.text),
        "purpose": Constants().getPurposeCode(Constants().sanitizeInputs(purposeController.text)),
        "whotosee" : Constants().sanitizeInputs(whoToSeeController.text),
        "floorofinterest": Constants().sanitizeInputs(floor),
        "tagno":  Constants().sanitizeInputs(tagNoController.text),
        "userid":  userid
           };

           final response = await http.post(Uri.parse(url),
          headers: {'Content-Type' : 'application/json'},
           body: jsonEncode(data));

           if(response.statusCode == 201){
        EasyLoading.showSuccess('Successfully');
        tagNoController.text = 'NBS/V/';
        clearTextFields();
           }else{
        EasyLoading.showError(jsonDecode(response.body)['message'],duration: Duration(seconds: 4));
           }
     } on SocketException catch (_) {
     EasyLoading.showError('Network error: No internet connection',duration: Duration(seconds: 5));
     }


  }

  Future<Map<String, dynamic>?> getTodayVisitors(BuildContext context) async {

    try {
      String? userid = await MyPreferences().getPreference('userid');
      // Check if userid is null or empty
      if (userid == null || userid.isEmpty) {
        _customSnackBarr(context, 'Receptionist not found');
        return {}; // Return an empty map to signify no data
      }

      String url = "https://www.smarterwayltd.com/ams/api/visitors/today/$userid";

      // Perform the HTTP GET request
      final response = await http.get(Uri.parse(url)).timeout(Duration(seconds: 5),onTimeout: (){
        throw TimeoutException(Constants().timeOutMessage());
      });

      // Check for a successful status code
      if (response.statusCode == 200) {
        return jsonDecode(response.body);

      } else{
       throw Exception('Failed to load data: ${jsonDecode(response.body)['message']}');
      }

    }on SocketException catch(_){
      throw Exception('No internet connection found');

    } on HandshakeException catch(_){
      throw Exception('No internet connection found');
    } catch (e) {
      throw Exception(e.toString());

    }
  }

  Future<void> getStatistics(BuildContext context) async {
    bool? networkStatus = await Constants().getNetworkStatus();
    if(!networkStatus){
      _customSnackBarr(context, 'No internet connection found');
      return;
    }

    String? userid = await MyPreferences().getPreference('userid');
    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );

    try {
      final response = await http.post(Uri.parse('https://www.smarterwayltd.com/ams/api/visitors/todaystatistics/'),
          headers: {'Content-Type' : 'application/json'},
          body: jsonEncode({
            "userid" : userid
          })).timeout(const Duration(seconds: 5),onTimeout: (){
            throw TimeoutException(Constants().timeOutMessage());
      });

      if (response.statusCode == 200) {

        resetValues();
        EasyLoading.showSuccess('Successfully');
        dynamic rawData = jsonDecode(response.body)['data'];

        for (var statusEntry in rawData['statusResults']) {
          String status = statusEntry['status'];
          if(status == '1'){
            inn = statusEntry['count'];
          }
          if(status == '0'){
            out = statusEntry['count'];
          }
          total = (inn+out).toString();

        }
        for(var purposeEntry in rawData['purposeResults']){
          String purpose = purposeEntry['purpose'];
          if(purpose == '2'){
            contract = purposeEntry['count'];
          }
          if(purpose == '3'){
            meeting = purposeEntry['count'];
          }
          if(purpose == '1'){
            research = purposeEntry['count'];
          }
          if(purpose == '4'){
            technical = purposeEntry['count'];
          }
          if(purpose == '5'){
            non = purposeEntry['count'];
          }

        }

        for (var floorEntry in rawData['floorResults']) {
          String floor = floorEntry['floorofinterest'];

          if(floor == '1'){
            if(floorEntry['status'] == '1'){
              first_inn = floorEntry['count'];
            }
            if(floorEntry['status'] == '0'){
              first_out = floorEntry['count'];
            }
          }
          if(floor == '2'){
            if(floorEntry['status'] == '1'){
              second_inn = floorEntry['count'];
            }
            if(floorEntry['status'] == '0'){
              second_out = floorEntry['count'];
            }
          }
          if(floor == '3'){
            if(floorEntry['status'] == '1'){
              third_inn = floorEntry['count'];
            }
            if(floorEntry['status'] == '0'){
              third_out = floorEntry['count'];
            }
          }
          if(floor == '4'){
            if(floorEntry['status'] == '1'){
              fourth_inn = floorEntry['count'];
            }
            if(floorEntry['status'] == '0'){
              fourth_out = floorEntry['count'];
            }
          }
          if(floor == '5'){
            if(floorEntry['status'] == '1'){
              fifth_inn = floorEntry['count'];
            }
            if(floorEntry['status'] == '0'){
              fifth_out = floorEntry['count'];
            }
          }
        }

        for(var satisfiedEntry in rawData['satisfiedResults']){
          String how = satisfiedEntry['how_satisfied'];
          if(how == '4'){
            five =  satisfiedEntry['count'];
          }
          if(how == '3'){
            four =  satisfiedEntry['count'];
          }
          if(how == '2'){
            three =  satisfiedEntry['count'];
          }
          if(how == '1'){
            two =  satisfiedEntry['count'];
          }
          if(how == '0'){
            one =  satisfiedEntry['count'];
          }

        }

      } else {

        EasyLoading.showError('Request failed: ${jsonDecode(response.body)['message']}.');
      }
    }on SocketException catch(_){
      EasyLoading.showError('No internet connection found');
    } catch (e) {
      EasyLoading.dismiss();

      _customSnackBarr(context, 'Error : ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> signOutNon(BuildContext context,String visitorid) async {

    await EasyLoading.show(
      status: 'loading...',
      maskType: EasyLoadingMaskType.black,
    );

    if(visitorid.isEmpty){
      EasyLoading.showInfo('Valid input required ');
      return;
    }

    try {
      String url = 'https://www.smarterwayltd.com/ams/api/visitors/signoutn';
      String? userid = await MyPreferences().getPreference('userid');
      //data to send
      Map<String,String?> data = {
        "userid":  userid,
        "visitorid" : visitorid
      };

      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type' : 'application/json'},
          body: jsonEncode(data)).timeout(const Duration(seconds: 5),onTimeout: (){
        throw TimeoutException(Constants().timeOutMessage());
      });

      if(response.statusCode == 200){

        EasyLoading.showSuccess('Successfully');
      }else{
      EasyLoading.showError(jsonDecode(response.body)['message']);
      }
    }on SocketException catch(_){
     EasyLoading.showError('No internet connection found');
    } catch (e) {
      EasyLoading.dismiss();
      _customSnackBarr(context, 'Error : ${e.toString()}');
    }
  }

  List<String> checkInputs(){
    List<String> error = [];
    if(nameController.text.isEmpty ){
      error.add('Full name');
    }
    if(addressController.text.isEmpty){
      error.add('address');
    }
    if(phoneController.text.isEmpty || phoneController.text.length != 11){
      error.add('phone number');
    }
    if(purposeController.text.isEmpty || ( !purposeController.text.contains('Research') && !purposeController.text.contains('Non-Official') &&
     !purposeController.text.contains('Contract') && !purposeController.text.contains('Technical Support') && !purposeController.text.contains('Meeting'))){
      error.add('purpose');
    }
    if(whoToSeeController.text.isEmpty ){
      error.add('WhoToSee');
    }
    if(floor.isEmpty){
      error.add('floor');
    }
    return error;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    purposeController.dispose();
    whoToSeeController.dispose();
    tagNoController.dispose();
    super.dispose();
  }

  void clearTextFields(){
    nameController.clear();
    addressController.clear();
    phoneController.clear();
    purposeController.clear();
    whoToSeeController.clear();
    resetCheckBox();
    tagNoController.clear();
  }

  customSnackBar(BuildContext context,String data){
    return  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data),backgroundColor: Colors.green,));

  }
  _customSnackBarr(BuildContext context,String data){
    return  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(data),backgroundColor: Colors.red,));

  }

  void updateCheckBox(int index, bool? value){
    for(int i = 0; i < satisfyvalue.length; i++){
      satisfyvalue[i] = i == index;
    }
    satisfyvalue[index] = value!;
    notifyListeners();
  }

  void resetCheckBox(){
    for(int i = 0; i < satisfyvalue.length; i++){
      satisfyvalue[i] = false;
    }
    notifyListeners();
  }



}





