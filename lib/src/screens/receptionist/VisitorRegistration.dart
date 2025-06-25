import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../providers/visitor_provider.dart';

class visitorRegistration extends StatefulWidget {
  const visitorRegistration({super.key});

  @override
  State<visitorRegistration> createState() => _visitorRegistrationState();
}

class _visitorRegistrationState extends State<visitorRegistration> {
  String? _selectedValue;
  final List<String> _purposeItems = ['Research','Contract','Technical Support', 'Meeting','Non-Official'];
  @override
  Widget build(BuildContext context) {
    final visitorProvider = Provider.of<VisitorProvider>(context);
    dynamic _textFormwidth = 400.0;
    return Theme( data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: Colors.green)),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Card(
              child: Column(
                children: [
                  SizedBox(height: 12,),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DropdownMenu<String>(initialSelection: '',
                      requestFocusOnTap: true, label: Text('Purpose'),
                      onSelected: (String? purpose){
                        setState(() {
                          _selectedValue = purpose;
                        });
                      },
                      dropdownMenuEntries: _purposeItems.map<DropdownMenuEntry<String>>((e) => DropdownMenuEntry<String>(value: e, label: e,
                          style: ButtonStyle(padding: WidgetStatePropertyAll(EdgeInsets.only(left:15,right: 200,))))).toList(),
                      controller: visitorProvider.purposeController,
                        inputFormatters: [FilteringTextInputFormatter(RegExp(r'A-Za-z0-9'), allow: true)]
                   ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox( width: 400,
                      child: TextFormField(decoration: InputDecoration(border: const OutlineInputBorder(),labelText: 'Name',
                          focusColor: Colors.green[900],focusedBorder: const OutlineInputBorder()),
                          controller: visitorProvider.nameController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox( width: _textFormwidth,
                      child: TextFormField(decoration: InputDecoration(border: const OutlineInputBorder(),labelText: 'Address',
                          focusColor: Colors.green[900],focusedBorder: const OutlineInputBorder()), controller: visitorProvider.addressController,
                        maxLines: 2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(width: _textFormwidth,
                      child: TextFormField(decoration: InputDecoration(border: const OutlineInputBorder(),labelText: 'Phone number',
                          focusColor: Colors.green[900],focusedBorder: const OutlineInputBorder()),
                          controller: visitorProvider.phoneController,maxLength: 11,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(width: _textFormwidth,
                      child: TextFormField(decoration: InputDecoration(border: const OutlineInputBorder(),labelText: 'Who to See',
                          focusColor: Colors.green[900],focusedBorder: const OutlineInputBorder()),controller: visitorProvider.whoToSeeController,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container( width: 400,decoration: BoxDecoration(border: Border.all(
                      color: Colors.black,),borderRadius: BorderRadius.all(Radius.circular(4))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text('Floor'),
                            SizedBox(width: 40,),
                            Checkbox(value: visitorProvider.satisfyvalue[0], onChanged: (value){
                              setState(() {
                                visitorProvider.updateCheckBox(0,value);

                                visitorProvider.floor = value! ? '1' : '';

                              });
                            },activeColor: Colors.green[900],),
                            const Text('1st'),
                            Checkbox(value: visitorProvider.satisfyvalue[1], onChanged: (value){
                              setState(() {
                             visitorProvider.updateCheckBox(1,value);
                                visitorProvider.floor = value! ? '2': '';
                              });
                            },activeColor: Colors.green[900],),
                            const Text('2nd'),
                            Checkbox(value: visitorProvider.satisfyvalue[2], onChanged: (value){
                              setState(() {
                               visitorProvider.updateCheckBox(2,value);
                                visitorProvider.floor =  value! ? '3': '';
                              });
                            },activeColor: Colors.green[900],),
                            const Text('3rd'),
                            Checkbox(value: visitorProvider.satisfyvalue[3], onChanged: (value){
                              setState(() {
                                visitorProvider.updateCheckBox(3,value);
                                visitorProvider.floor  = value! ? '4' : '';
                              });
                            },activeColor: Colors.green[900],),
                            const Text('4th'),
                            Checkbox(value: visitorProvider.satisfyvalue[4], onChanged: (value){
                              setState(() {
                                visitorProvider.updateCheckBox(4,value);
                                visitorProvider.floor  = value! ?  '5' :  '';
                              });
                            },activeColor: Colors.green[900],),
                            const Text('5th')
                          ],),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(width: _textFormwidth,
                      child: TextFormField(decoration: InputDecoration(border: const OutlineInputBorder(),labelText: 'Tag no',
                          focusColor: Colors.green[900],focusedBorder: const OutlineInputBorder(),
                      prefixText: 'NBS/V/'),controller: visitorProvider.tagNoController,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){visitorProvider.submit(context);}, child: const Padding(
                      padding: EdgeInsets.only(left: 30,right: 30,top: 16,bottom: 16),
                      child: Text('Save',style: TextStyle(color: Colors.white),),
                    ),style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.green[900])),),
                  ),

                ],
              ),
            ),
          ),
        ),

      ),
    );
  }
}
