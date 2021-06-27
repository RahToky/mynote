import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_note/const/strings.dart';

class ConfirmDialog extends StatelessWidget {

  final BuildContext _context;

  ConfirmDialog(this._context);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(kConfirm),
      content: Text(kSureToDel),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(kCancel),
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey,
          ),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: Text(kRemove),
          style: TextButton.styleFrom(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }
}