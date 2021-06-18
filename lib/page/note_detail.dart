import 'package:flutter/material.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/util/color_util.dart';

import 'include/app_bar_detail.dart';
import 'include/note_card.dart';

class NoteDetailPage extends StatelessWidget {
  static const routeName = "/detail";

  @override
  Widget build(BuildContext context) {
    Note note;
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) note = arguments['note'];
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyAppBarDetail(),
      body: Container(
        width: size.width,
        height: size.height - kToolbarHeight * 2,
        alignment: Alignment.topLeft,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: HexColor(note.cardBackgroundColor),
          border: Border.all(
            color: note.cardBorderColor == null
                ? Colors.transparent
                : HexColor(note.cardBorderColor),
            width: note.cardBorderColor == null ? 0 : 2,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardTitle(note, 24),
              Divider(
                height: 20,
                color: Colors.white70,
              ),
              Text('${note.content}',
                  style: TextStyle(
                      fontSize: 16, color: HexColor(note.cardForgroundColor))),
            ],
          ),
        ),
      ),
    );
  }
}
