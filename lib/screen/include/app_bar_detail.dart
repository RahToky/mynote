import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_note/callback/icon_callback.dart';
import 'package:my_note/const/strings.dart';

class MyAppBarDetail extends StatelessWidget implements PreferredSizeWidget {

  static final String editTag = "edit";
  static final String delTag = "delete";

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  IconClickListener _iconClickListener;

  MyAppBarDetail(this._iconClickListener);

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
          ),
          onPressed: () {
            _iconClickListener.onIconClick(editTag);
          },
        ),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
          onPressed: () {
            _iconClickListener.onIconClick(delTag);},
        ),
      ],
    );
  }
}
