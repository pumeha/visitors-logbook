import 'package:flutter/material.dart';

class customAppBarTitle extends StatefulWidget implements PreferredSizeWidget{
  final String title;
  const customAppBarTitle({super.key,required this.title});

  @override
  State<customAppBarTitle> createState() => _customAppBarTitleState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _customAppBarTitleState extends State<customAppBarTitle> {
  @override
  Widget build(BuildContext context) {
      return  Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(child: Image.asset('images/img.png'),height: 40,width: 40,),
          ),
          Text(widget.title,
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.w800,color: Colors.green[900]))
        ],
      );
  }
}
