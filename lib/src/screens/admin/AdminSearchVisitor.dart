
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../providers/search_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/ViewVisitorListChild2.dart';


class AdminSearchVisitor extends StatefulWidget {
  const AdminSearchVisitor({super.key});

  @override
  State<AdminSearchVisitor> createState() => _AdminSearchVisitorState();
}

class _AdminSearchVisitorState extends State<AdminSearchVisitor> {
  List<String> _search_items = ['Name','Phone number'];
  String _selected_search_item = '';
  String _status = '';
  bool value = false;
  List<dynamic>? data = [];
  late int t = 0;


  @override
  Widget build(BuildContext context) {
context.read<SearchProvider>().searchInput.clear();
    data = context.watch<SearchProvider>().data;


    return Scaffold(
      body: Theme(data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: Colors.green)),
          child: Column(
            children: [
              const SizedBox(height: 36,),
              Row( mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 12,),
                  DropdownMenu(dropdownMenuEntries: _search_items.map<DropdownMenuEntry<String>>((e) =>
                      DropdownMenuEntry(value: e, label: e)).toList(),
                    requestFocusOnTap: true,label: const Text('Search with'),
                    onSelected: (value){
                      setState(() {
                        context.read<SearchProvider>().searchInput.clear();
                        _selected_search_item = value!;
                        if(_selected_search_item.isNotEmpty){
                          if(_selected_search_item == 'Name'){
                              _status = '1';
                          }
                          if(_selected_search_item == 'Phone number'){
                            _status = '0';
                          }
                        }
                      });
                    }, inputFormatters: [FilteringTextInputFormatter(RegExp(r'A-Za-z0-9'), allow: true)]),
                  const SizedBox(width: 12,),
                  SizedBox(width: 300,child: TextField( cursorColor: Colors.green[900],
                    decoration: InputDecoration(hintText: 'Type ${_selected_search_item}'),
                    controller: context.watch<SearchProvider>().searchInput,
                    inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]'))],
                 ),),
                  ElevatedButton.icon(onPressed: () async {
                    if(_status != '1' || _status != '0') {
                   context.read<SearchProvider>().searchVisitor(_status);
                    }
                  }, icon: const Icon(Icons.search_rounded,color: Colors.white,),
                      label: const Text('Search',style: TextStyle(color: Colors.white),),
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green)),),
               data != null ?  Padding(padding: EdgeInsets.only(left: 36),child: Text('${data!.length}',
                 style: TextStyle(fontWeight: FontWeight.bold),),) : Text('')
                ],
              ),
          MediaQuery.of(context).size.width < 950 ?
          Expanded(
             child: data == null || data!.isEmpty  ? Text('No Record Found') : ListView.builder( itemCount: data!.length,
                 itemBuilder: (context,index){
                  final visitor1 = data![index];
                  return Viewvisitorlistchild2(fullname: visitor1['fullname'],
                    tagno: visitor1['tagno'],
                    floorofInterest: visitor1['floorofinterest'],
                    purpose: Constants().getPurposeValue(visitor1['purpose']),
                    phonumber: visitor1['phonenumber'],
                    whotosee: visitor1['whotosee'],
                    address: visitor1['address'],
                    time_in: visitor1['time_in'],
                    time_out: visitor1['time_out'],
                    status: visitor1['status'],
                    date: Constants().getDate(visitor1['date'])
                  );
             }),
           ) 
              :
          Expanded(
            child: data == null || data!.isEmpty  ? Text('No Record Found') : ListView.builder( itemCount: (data!.length / 2).ceil(),
                itemBuilder: (context,index){

                  final visitor1 = data![index];

                  final visitor2 = (index * 2 + 1 < data!.length) ? data![index * 2 + 1] : null;

                  return Row( mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Viewvisitorlistchild2(fullname: visitor1['fullname'],
                        tagno: visitor1['tagno'],
                        floorofInterest: visitor1['floorofinterest'],
                        purpose: Constants().getPurposeValue(visitor1['purpose']),
                        phonumber: visitor1['phonenumber'],
                        whotosee: visitor1['whotosee'],
                        address: visitor1['address'],
                        time_in: visitor1['time_in'],
                        time_out: visitor1['time_out'],
                        status: visitor1['status'],
                          date: Constants().getDate(visitor1['date'])
                      ),

                      if(visitor2 != null)  Viewvisitorlistchild2(fullname: visitor2['fullname'],
                          tagno: visitor2['tagno'],
                          floorofInterest: visitor2['floorofinterest'],
                          purpose: Constants().getPurposeValue(visitor2['purpose']),
                          phonumber: visitor2['phonenumber'],
                          whotosee: visitor2['whotosee'],
                          address: visitor2['address'],
                          time_in: visitor2['time_in'],
                          time_out: visitor2['time_out'],
                          status: visitor2['status'],  date: Constants().getDate(visitor2['date'])
                      ),
                    ],
                  );
                }),
          )
            ],
          )),
    );
  }
}
