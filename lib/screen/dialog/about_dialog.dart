import 'dart:developer';

import 'package:flutter/material.dart';

class MyAboutDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 2,
      backgroundColor: Colors.transparent,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        height: size.height*0.2,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Mes Notes", style: const TextStyle(fontWeight: FontWeight.bold),),
            const Text("v 1.0.0"),
            const Divider(thickness: 1,),
            const Text("mahatoky.rasolonirina@gmail.com",style: const TextStyle(color:Colors.grey,fontSize: 14),),
          ],
        ),
      ),);
  }
}
