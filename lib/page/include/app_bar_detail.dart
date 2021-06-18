import 'package:flutter/material.dart';
import 'package:my_note/const/strings.dart';

class MyAppBarDetail extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(kAppName),
      actions: [
        IconButton(
            icon: Icon(
              Icons.edit,
              color: Colors.blue,
            )),
        IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            )),
      ],
    );
  }
}