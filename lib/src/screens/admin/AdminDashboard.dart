
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/dashboard_provider.dart';
import '../../widgets/customHVScrollbar.dart';
import '../../widgets/floorchart.dart';
import '../../widgets/purposechart.dart';
import '../../widgets/satifiedChart.dart';
import '../../widgets/statuschart.dart';
class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();


}

class _AdminDashboardState extends State<AdminDashboard> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardProvider  = Provider.of<DashboardProvider>(context);
    double inn = dashboardProvider.inn.toDouble();
    double out =  dashboardProvider.out.toDouble();
    double non  = dashboardProvider.non.toDouble();
    double technical =  dashboardProvider.technical.toDouble();
    double contract = dashboardProvider.contract.toDouble();
    double meeting = dashboardProvider.meeting.toDouble();
    double research = dashboardProvider.research.toDouble();
    double five = dashboardProvider.five.toDouble();
    double four = dashboardProvider.four.toDouble();
    double three = dashboardProvider.three.toDouble();
    double two = dashboardProvider.two.toDouble();
    double one = dashboardProvider.one.toDouble();

    return Scaffold(
      body: CustomHVScrollBar(child: Column(
        children: [
          Card( color: Colors.green[50],
            child: Row( mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: (){
                  dashboardProvider.showDatePicker(context);
                }, child: const Text(' Select Date Range', style: TextStyle(color: Colors.white,),
                ),style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('  Start Date \n' + dashboardProvider.startDate,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('  End Date: \n'+dashboardProvider.endDate,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                ),
                IconButton(onPressed: (){
                  context.read<DashboardProvider>().fetchRangeData();
                }, icon: SizedBox(child: Image.asset('images/refreshdata.png'),
                  width: 40,height: 40,)),
                ElevatedButton(onPressed: (){
                  context.read<DashboardProvider>().downloadData();
                }, child: const Text('Download Rawdata', style: TextStyle(color: Colors.white,),
                ),style: const ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),)
              ],),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               Card(child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: StatusChart( inn: inn, out: out)
                ),),
                Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Column(children: [
                    SizedBox(
                      height: 150,width: 150,
                      child: Card(child: Column(children: [
                        Text('Total Visitors',
                          style: TextStyle(fontSize: 24,backgroundColor: Colors.green[800],
                            color: Colors.white),),

                       Padding(
                          padding:  const EdgeInsets.all(16),
                          child: Text(dashboardProvider.total,
                            style: const TextStyle(fontSize: 48,fontWeight: FontWeight.w800),),
                        )],),),
                    ),
                  ],),
                ),
                Card(child: Padding(padding: const EdgeInsets.all(12),child:  
                PurposeChart( non: non,technical: technical,research: research,
                  meeting: meeting,contract: contract,
                ),)),
              ],
            ),

          ),

          Row( crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloorChart(provider: dashboardProvider,),
              Padding(padding: const EdgeInsets.only(left: 24,right: 24),
                child:  Card(child: Padding(padding: const EdgeInsets.all(12),
                  child: SatifiedChart(five: five, four: four, three: three, two: two, one: one),)),),

            ],
          ),
        ],
      )),
    );

  }
}
