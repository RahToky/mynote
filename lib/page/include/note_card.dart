import 'package:flutter/material.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/page/note_detail.dart';
import 'package:my_note/util/color_util.dart';

import '../note_add.dart';

class NoteCard extends StatelessWidget {
  final Note note;

  NoteCard(this.note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: kToolbarHeight + 0.5 * kToolbarHeight,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.topLeft,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardTitle(note,18),
            const SizedBox(height: 5),
            Flexible(
              child: Text(
                note.content,
                style: TextStyle(
                  color: HexColor(note.cardForgroundColor),
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, NoteDetailPage.routeName,
            arguments: {'note': note});
      },
    );
  }
}


cardTitle(Note note, double size) => Row(
  children: [
    Expanded(
      child: Text(
        note.title,
        style: TextStyle(
          color: HexColor(note.cardForgroundColor),
          fontSize: size,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    ),
    if (note.firstIconCodePoint != null)
      Icon(
        IconData(note.firstIconCodePoint,
            fontFamily: "MaterialIcons"),
        color: HexColor(note.cardForgroundColor),
      ),
    if (note.secondIconCodePoint != null)
      Icon(
        IconData(note.secondIconCodePoint,
            fontFamily: "MaterialIcons"),
        color: HexColor(note.cardForgroundColor),
      ),
  ],
); 