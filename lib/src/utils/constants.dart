import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Constants{


   void showAlertDialogLikeToast(BuildContext context,String message,Color color) {
     // Show the AlertDialog
     showDialog(
       context: context,
       builder: (BuildContext context) {

         Future.delayed(const Duration(seconds: 1), () {
           Navigator.of(context).pop();
         });
         return Stack(
           children: [
             Positioned(
               bottom: 100, // Distance from the bottom
               left: MediaQuery.of(context).size.width * 0.3,
               right: MediaQuery.of(context).size.width * 0.3,// Center horizontally
               child: Card(
                 color: color,
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                     message,
                     style: const TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w800),
                     textAlign: TextAlign.center,
                   ),
                 ),
               ),
             ),
           ],
         );
       },
       barrierDismissible: false, // Prevent tap outside to close immediately
     );
   }


   Future<bool> getNetworkStatus() async{
     try{
       final result = await InternetAddress.lookup('google.com');
       if(result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
       }

       return true;
     }on SocketException catch(_){
       return false;
     }

   }

   DateTime currentTime(){
     DateTime time = DateTime.now();
     return time;
   }
   Future<void> load() async {
    await EasyLoading.show(
       status: 'loading...',
       maskType: EasyLoadingMaskType.black,
     );
   }

   String convertJsonToCsv(List<Map<String, dynamic>> jsonData) {
     if (jsonData.isEmpty) return '';

     final buffer = StringBuffer();

     // Create headers from the keys of the first item in the list
     buffer.writeln(jsonData.first.keys.join(','));

     // Add values for each map in the list
     for (var item in jsonData) {
       buffer.writeln(item.values.map((value) => value.toString()).join(','));
     }

     return buffer.toString();
   }

   Future<void> saveCsvToFile(String csv,String filename) async {
     // Get the user's home directory
     final homeDir = Directory.systemTemp.parent; // Use a temporary directory as an alternative
     final path = '${homeDir.path.split('\\')[0] +'\\'+ homeDir.path.split('\\')[1] + '\\'+
         homeDir.path.split('\\')[2] +'\\' + 'Downloads\\'}/${filename}.csv'; // Modify the path as needed
     final file = File(path);

     // Write the CSV data to the file
     await file.writeAsString(csv);
   }

   String sanitizeInputs(String data){
     final pattern = RegExp(r'[,@!#$%^&*?/\|]');
     return data.replaceAll(pattern, '');
   }

   String getPurposeCode(String purpose){
     switch(purpose){
       case 'Research':
         return '1';
       case 'Contract' :
         return '2';
       case 'Meeting' :
         return '3';
       case 'Technical Support' :
         return '4';
       case 'Non-Official' :
         return '5';
       default:
         return '??';
     }

   }

   String getPurposeValue(String code){
     switch(code){
       case '1':
         return 'Research';
       case '2':
         return 'Contract' ;
       case '3' :
         return 'Meeting';
       case '4' :
         return 'Technical Support';
       case '5' :
         return 'Non-Official';
       default:
         return '??';
     }

   }

   String getDate(date){
     DateTime dateTime = DateTime.parse(date);
  String datee = "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  return datee;
   }

  String timeOutMessage() {
     return "Connection has timed out. Please check your network and try again.";
  }

}