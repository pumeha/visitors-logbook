import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Viewvisitorlistchild extends StatelessWidget {
  final  String fullname,tagno,floorofInterest,phonumber,purpose,whotosee,address,time_in,time_out,status;
  final VoidCallback onPressed;
 const Viewvisitorlistchild({super.key,required this.fullname,required this.tagno, required this.floorofInterest,
      required this.phonumber,required this.purpose,required this.whotosee,required this.onPressed, required this.address,
    required this.time_in, required this.time_out, required this.status});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 450,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Card(
                color: Colors.white,
                child: Row(
                  children: [

                    Expanded(
                      child: Column(
                        children: [
                          Container(  color: Colors.green[200],
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8,left: 8,right: 8,bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(fullname,style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(phonumber,style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(tagno,style: TextStyle(fontWeight: FontWeight.bold),)
                                ],
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 8,right: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(purpose,style: TextStyle(fontWeight: FontWeight.w500),),
                              Text(whotosee,style: TextStyle(fontWeight: FontWeight.w500),),
                              Container(child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(floorofInterest,style: TextStyle(fontWeight: FontWeight.w500),),
                              ),decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.green,width: 2)
                              ),)
                            ],
                          ),),
                         Padding(
                           padding: const EdgeInsets.all(8),
                           child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [

                               Expanded(child: Text(address,)),
                               Row(children: [
                                 Padding(
                                   padding: const EdgeInsets.only(left: 12),
                                   child: SizedBox(child: Image.asset('images/clock (2).png'),height: 20,width: 20,),
                                 ),
                                 SizedBox(width: 4,),
                                 Text(time_in,style: TextStyle(fontWeight: FontWeight.w500),),
                                 SizedBox(width: 12,),

                                 status == '1' ?
                                 TextButton(onPressed: onPressed, child: Text('Sign Out',style: TextStyle(color: Colors.amber),))
                                     :Row(
                                       children: [
                                         Padding(
                                           padding: const EdgeInsets.only(left: 12),
                                           child: SizedBox(child: Image.asset('images/clock.png'),height: 20,width: 20,),), SizedBox(width: 4,),
                                         Text(time_out,style: TextStyle(fontWeight: FontWeight.w500))
                                       ],
                                     ),
                               ],),

                             ],
                           ),
                         )
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
