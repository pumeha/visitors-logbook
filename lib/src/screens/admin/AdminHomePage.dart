
import 'package:attendance_system/src/providers/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/search_provider.dart';
import '../../providers/users_provider.dart';
import '../../widgets/CustomAppBarTitle.dart';
import 'AdminDashboard.dart';
import 'AdminSearchVisitor.dart';
import 'AdminUsersPage.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {

  @override
  Widget build(BuildContext context) {
    return Theme(

      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.light(primary: Colors.green,
        )
      ),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(

          appBar: AppBar(title: const customAppBarTitle(title: 'Admin Dashboard: Visitor\'s Logbook',),
            bottom: TabBar(tabs: const [
            Tab(text: 'Dashboard',),
            Tab(text: 'Search Visitor',),
            Tab(text: 'Users',)
          ],indicatorColor: Colors.green[900],labelColor: Colors.green[900],),
          actions: [
            PopupMenuButton(itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Sign Out'),value: 'sign out',),
            ],
            onSelected: (value){
              context.read<DashboardProvider>().resetValues();
              context.read<DashboardProvider>().resetDate();
              context.read<UsersProvider>().usersdata.clear();// clear the users data
              context.read<SearchProvider>().data = [];

             Navigator.pop(context);
            },)
          ],automaticallyImplyLeading: false,),
            body: const TabBarView(children: [
              AdminDashboard(),
              AdminSearchVisitor(),
              Users(),
            ]),
        ),
      ),
    );
  }
}
