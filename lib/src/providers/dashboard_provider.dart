import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import '../services/apis/dashboardApi.dart';

class DashboardProvider with ChangeNotifier{
  late String _startDate = '',_endDate = '';
  late int inn = 0;
  late int out = 0;
  late int contract  = 0;
  late int meeting = 0;
  late int research = 0;
  late int non = 0;
  late int technical = 0;
  late String total = '0';

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
    inn = 0; out = 0;
    contract = 0;
    meeting = 0;
    research = 0;
    non = 0 ;
    technical = 0;
    first_inn = 0;
    first_out = 0;
    total = '0';
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


  Future<void> showDatePicker(BuildContext context) async {

    showDateRangePicker(context: context, firstDate: DateTime(2024,11,10),
        lastDate: DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
        initialEntryMode: DatePickerEntryMode.calendarOnly).then((onValue){
          if (onValue != null) {
            startDate = '${onValue.start.day} / ${onValue.start.month} / ${onValue.start.year}';
            endDate = '${onValue.end.day} / ${onValue.end.month} / ${onValue.end.year}';

            notifyListeners();
          }
    });
  }



  get endDate => _endDate;

  String get startDate => _startDate;

  set startDate(String value) {
    _startDate = value;
  }

  set endDate(value) {
    _endDate = value;
  }

  void resetDate(){
    _startDate = '';
    _endDate = '';
  }

  Future<void> fetchRangeData() async {
    if(startDate.isEmpty || endDate.isEmpty){
      EasyLoading().backgroundColor = Colors.green;
      EasyLoading.showError('Kindly pick date of interest');
      return;
    }

   String fromday = startDate.split('/')[0].trim().length == 2 ? startDate.split('/')[0].trim() : '0'+startDate.split('/')[0].trim();
    String frommonth = startDate.split('/')[1].trim().length == 2 ? startDate.split('/')[1].trim() : '0'+startDate.split('/')[1].trim();

    String from = startDate.split('/')[2].trim() + '-' + frommonth +'-'+ fromday;

    String today = endDate.split('/')[0].trim().length == 2 ? endDate.split('/')[0].trim() : '0'+endDate.split('/')[0].trim();
    String tomonth = endDate.split('/')[1].trim().length == 2 ? endDate.split('/')[1].trim() : '0'+endDate.split('/')[1].trim();
    String to = endDate.split('/')[2].trim() + '-' +tomonth+'-'+ today;


  dynamic response = await  DashboardApi().dashBoardData(from,to);
  resetValues();
    if(response == null){
      return;
    }
    dynamic rawData = jsonDecode(response)['data'];


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
    notifyListeners();
  }
  Future<void> downloadData() async{
    if(startDate.isEmpty || endDate.isEmpty){
      EasyLoading().backgroundColor = Colors.green;
      EasyLoading.showError('Kindly pick date of interest');
      return;
    }
    String fromday = startDate.split('/')[0].trim().length == 2 ? startDate.split('/')[0].trim() : '0'+startDate.split('/')[0].trim();
    String frommonth = startDate.split('/')[1].trim().length == 2 ? startDate.split('/')[1].trim() : '0'+startDate.split('/')[1].trim();

    String from = startDate.split('/')[2].trim() + '-' + frommonth +'-'+ fromday;

    String today = endDate.split('/')[0].trim().length == 2 ? endDate.split('/')[0].trim() : '0'+endDate.split('/')[0].trim();
    String tomonth = endDate.split('/')[1].trim().length == 2 ? endDate.split('/')[1].trim() : '0'+endDate.split('/')[1].trim();
    String to = endDate.split('/')[2].trim() + '-' +tomonth+'-'+ today;


    DashboardApi().getData(from,to);
  }

}