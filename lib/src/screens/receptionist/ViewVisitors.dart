
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../providers/survey_provider.dart';
import '../../providers/visitor_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/ViewVisitorListChild.dart';



class viewVisitor extends StatefulWidget {
  viewVisitor({super.key});
  String vid = '';

  @override
  State<viewVisitor> createState() => _viewVisitorState();


}

class _viewVisitorState extends State<viewVisitor> {


  Future<void> _satisfactionDialog(String visitorid) async{
    context.read<SurveyProvider>().resetCheckBoxYN();
    context.read<SurveyProvider>().resetCheckBox();
    context.read<SurveyProvider>().error = '';
      return showDialog(context: context,
          barrierDismissible: false,
          builder: (BuildContext context){
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Center(child: Text('Visitor Satisfaction Survey',style: TextStyle(color: Colors.green[900],fontWeight: FontWeight.bold),)),
          content: Consumer<SurveyProvider>(
            builder: (context,survey,child) {
              return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24,),
                  const Text(' Are you satisfied with our services? ',style: TextStyle(fontSize: 24,fontWeight: FontWeight.w400),),
                  const Divider(color: Colors.black,),
                  const SizedBox(height: 14,),
                  Row(
                    children: [
                      Checkbox(value: survey.yesNo[1], onChanged:(v){
                        survey.updateCheckBoxYN(1);
                        survey.resetCheckBox();
                      },checkColor: Colors.white,),
                      Text('If Yes, How satisfied are you with Bureau Services',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.green[900]),),
                    ],
                  ),
                  const Divider(color: Colors.black,),
                  const SizedBox(height: 14,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(value: survey.satisfyvalue[0], onChanged: (value){
                        survey.updateCheckBox(0);
                      },activeColor: Colors.green[900],),
                      const Text('Strongly Satisfied'),
                      const SizedBox(width: 36,),
                      Checkbox(value: survey.satisfyvalue[1], onChanged: (value){
                        survey.updateCheckBox(1);
                      },activeColor: Colors.green[900],),
                      const Text('Satisfied'),
                      const SizedBox(width: 36,),
                      Checkbox(value: survey.satisfyvalue[2], onChanged: (value){
                        survey.updateCheckBox(2);
                      },activeColor: Colors.green[900],),
                      const Text('Indifference'),
                    ],),
                  Row(  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(value: survey.satisfyvalue[3], onChanged: (value){
                        survey.updateCheckBox(3);
                      },activeColor: Colors.green[900],),
                      const Text('Not Satisfied'),
                      const SizedBox(width: 36,),
                      Checkbox(value: survey.satisfyvalue[4], onChanged: (value){
                        survey.updateCheckBox(4);
                      },activeColor: Colors.green[900],),
                      const Text('Strongly Not Satisfied')
                    ],),
                  const Divider(color: Colors.black,),
                 Row(
                   children: [
                     Checkbox(value: survey.yesNo[0], onChanged: (v){
                       survey.updateCheckBoxYN(0);
                       survey.resetCheckBox();
                     },checkColor: Colors.white,),
                     Text('If No',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16,color: Colors.red),),
                   ],
                 ),
                 SizedBox(
                   width:  400,
                   child: TextFormField(decoration: InputDecoration(border: const OutlineInputBorder(),labelText: 'Please Give Reasons',
                       focusColor: Colors.green[900],focusedBorder: const OutlineInputBorder()),
                     maxLines: 4, minLines: 1, enabled: survey.editableForNoReasonsText,
                     controller: survey.noreasons,
                   ),
                 ),
                  Text(survey.error,style: TextStyle(color: Colors.red),)
          ],),
            );  },),
          actions: [
            TextButton(onPressed: ()=>  Navigator.of(context).pop(), child: const Text('Cancel',style: TextStyle(color: Colors.red),)),
            TextButton(onPressed: () async {
                     await context.read<SurveyProvider>().submit(context, visitorid);
                     refresh();
                      }, child: Text('Submit',style: TextStyle(color: Colors.green[900]),))
          ],);
          });
  }

  @override
  void initState() {
    super.initState();
  }
  void refresh(){
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body: FutureBuilder(
          future: context.watch<VisitorProvider>().getTodayVisitors(context),
          builder: (context,snapShotdata){
            if(snapShotdata.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator.adaptive(backgroundColor: Colors.green,strokeWidth: 8,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),),);
            }else if(snapShotdata.hasError){
              return Center(child: Text('${snapShotdata.error}',style: TextStyle(color: Colors.red,fontSize: 24),));
            }else if (snapShotdata.hasData ) {
              List<dynamic> visitors = snapShotdata.data!['data'];
              if(visitors.isEmpty) {
                return const Center(child: Text('no record found',style: TextStyle(color: Colors.red,fontSize: 24),));
              } else {
                return ListView.builder(
                    itemCount: visitors.length, itemBuilder: (context, index) {
                  final visitor = visitors[index];
                  String purpose = visitor['purpose'];
                  return Viewvisitorlistchild(fullname: visitor['fullname'],
                    tagno: 'NBS/V/'+visitor['tagno'],
                    floorofInterest: visitor['floorofinterest'],
                    purpose: Constants().getPurposeValue(visitor['purpose']),
                    phonumber: visitor['phonenumber'],
                    whotosee: visitor['whotosee'],
                    onPressed: purpose.contains('Non') ?
                        () async {
                      await context.read<VisitorProvider>().signOutNon(context,
                          visitor['visitorid']);
                      refresh();
                    } : () {
                      _satisfactionDialog(visitor['visitorid']);
                    },
                    address: visitor['address'],
                    time_in: visitor['time_in'],
                    time_out: visitor['time_out'],
                    status: visitor['status'],
                  );
                });
              }
            }else{
              return const Center(child: Text('no data available...try again',style: TextStyle(color: Colors.red,fontSize: 24),));
            }

          }),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {

        });
      },
      child: Padding(padding: EdgeInsets.all(12),child: Image.asset('images/refreshdata.png'),),),


    );
  }
}

