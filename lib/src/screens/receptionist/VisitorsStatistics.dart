
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../providers/visitor_provider.dart';
import '../../widgets/customHVScrollbar.dart';
import '../../widgets/floorchart.dart';
import '../../widgets/purposechart.dart';
import '../../widgets/satifiedChart.dart';
import '../../widgets/statuschart.dart';

class visitorStatistics extends StatelessWidget {
  const visitorStatistics({super.key});


  @override
  Widget build(BuildContext context) {
    double inn = context.watch<VisitorProvider>().inn.toDouble();
    double out =  context.watch<VisitorProvider>().out.toDouble();
    final visitorsProvider = Provider.of<VisitorProvider>(context);
    double non  = visitorsProvider.non.toDouble();
    double technical =  visitorsProvider.technical.toDouble();
    double contract = visitorsProvider.contract.toDouble();
    double meeting = visitorsProvider.meeting.toDouble();
    double research = visitorsProvider.research.toDouble();
    double five = visitorsProvider.five.toDouble();
    double four = visitorsProvider.four.toDouble();
    double three = visitorsProvider.three.toDouble();
    double two = visitorsProvider.two.toDouble();
    double one = visitorsProvider.one.toDouble();



    return Scaffold(
      body: CustomHVScrollBar(child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: StatusChart(inn: inn,out: out,),
                ),),
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Column(children: [
                    SizedBox(
                      height: 150,width: 150,
                      child: Card(child: Column(children: [
                        Text('Total Visitors',style: TextStyle(fontSize: 24,backgroundColor: Colors.green[800],
                            color: Colors.white),),

                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(context.watch<VisitorProvider>().total,style: TextStyle(fontSize: 48,fontWeight: FontWeight.w800),),
                        )],),),
                    ),
                  ],),
                ),
                Card(child: Padding(padding: const EdgeInsets.all(12),child: PurposeChart(
                   non: non,technical: technical,research: research,
                  meeting: meeting,contract: contract,
                ),)),
              ],
            ),

          ),

          Row(
            children: [
              FloorChart(provider: visitorsProvider,),
              Padding(
                padding: const EdgeInsets.only(left: 50,right: 50),
                child: Card(child: Padding(padding: const EdgeInsets.all(12),
                  child: SatifiedChart(five: five, four: four, three: three, two: two, one: one),)),
              ),
            ],
          )


        ],
      ),),
      floatingActionButton: FloatingActionButton(onPressed: () async{
        context.read<VisitorProvider>().getStatistics(context);
      },
      child: Padding(padding: EdgeInsets.all(12),child: Image.asset('images/refreshdata.png'),),),
    );
  }
}



