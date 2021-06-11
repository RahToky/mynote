import 'package:flutter/material.dart';

class AboutDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(child: Text("test"),),// bottom part
          Positioned(child: Text("positioned"),),// top part
        ],
      ),
    );
  }
}
