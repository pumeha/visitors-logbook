import '../../widgets/CustomAppBarTitle.dart';
import 'ViewVisitors.dart';
import 'VisitorRegistration.dart';
import 'VisitorsStatistics.dart';
import 'package:flutter/material.dart';

class receptionistHomePage extends StatelessWidget {
  const receptionistHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Theme(
      data: Theme.of(context).copyWith(colorScheme: ColorScheme.light(primary: Colors.green)),
      child: DefaultTabController( length: 3,
        child: Scaffold(
        appBar: AppBar(

          title: const customAppBarTitle(title: 'Visitor\'s Logbook'),
          bottom:   TabBar(tabs: [
          Tab(text: 'Visitor Registration',),
          Tab(text: 'View Visitors',),
          Tab(text: 'Dashboard',)
        ],indicatorColor: Colors.green[900],
            labelStyle: TextStyle(color: Colors.green[900],fontWeight: FontWeight.w600),),
        actions: [

          PopupMenuButton(itemBuilder: (context) => [
            PopupMenuItem(child: Text('Sign Out'), value: 'sign out',),

          ],
          onSelected: (value){
            if(value == 'sign out') {
              Navigator.pop(context);}
          },)
        ],automaticallyImplyLeading: false,),
          body: TabBarView(children: [
              visitorRegistration(),
            viewVisitor(),
            visitorStatistics()
          ],),
        ),
      ),
    );
  }
}
