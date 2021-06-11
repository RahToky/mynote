import 'package:flutter/material.dart';
import 'package:my_note/const/colors.dart';
import 'package:my_note/const/strings.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/service/note_service.dart';
import 'package:my_note/util/color_util.dart';

import 'include/app_bar.dart';

class NoteAddPage2 extends StatefulWidget {
  static const routeName = "/add2";

  @override
  _NoteAddPage2State createState() => _NoteAddPage2State();
}

class _NoteAddPage2State extends State<NoteAddPage2> {
  Note note;
  final NoteService _noteService = NoteService();
  final List<Map<String, String>> hexColors = MyColors.getHexMapColors();
  bool isEditing = false;

  void initNote(context) {
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) note = arguments['note'];
    if (note == null) {
      isEditing = true;
      note = Note();
      note.cardForgroundColor = hexColors[1]['cardForgroundColor'];
      note.cardBackgroundColor = hexColors[1]['cardBackgroundColor'];
      note.cardBorderColor = hexColors[1]['cardBorderColor'];
    }
  }

  @override
  Widget build(BuildContext context) {
    initNote(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyAppBarAdd(isEditing?kEdit:kNew),
      body: SingleChildScrollView(
        child: Column(
          children: [
            createBox(
              height:size.height - kToolbarHeight * 3,
              width:size.width,
              backgroundColor:HexColor(note.cardBackgroundColor),
              borderColor:note.cardBorderColor == null
                  ? Colors.transparent
                  : HexColor(note.cardBorderColor),
              widgetChild:SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(height: 40, child: addNoteHeader(note)),
                    SizedBox(height: 10),
                    TextField(
                      maxLines: null,
                      decoration: new InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Déscription....',
                        hintStyle: TextStyle(
                          color: HexColor(note.cardForgroundColor),
                        )
                      ),
                      style:
                          TextStyle(color: HexColor(note.cardForgroundColor)),
                    ),
                  ],
                ),
              ),
            ),

            Container(
              width: size.width,
              height: kToolbarHeight,
              margin: EdgeInsets.all(10),
              child: TextButton(
                onPressed: () {
                  saveNote(context);
                },
                child: Text(
                  kSave,
                  style: TextStyle(fontSize: 18),
                ),
                style: Theme.of(context).textButtonTheme.style,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveNote(context) async {
    // Note note = Note(
    //   title: _titleController.text,
    //   content: _contentController.text,
    //   cardBackgroundColor: hexColors[selectedThemeId]['cardBackgroundColor'],
    //   cardForgroundColor: hexColors[selectedThemeId]['cardForgroundColor'],
    //   cardBorderColor: hexColors[selectedThemeId]['cardBorderColor'],
    //   isLocked: 0,
    // );
    // await _noteService.saveNote(note);
    // Navigator.pop(context);
  }
}

Container createBox({height, width, backgroundColor, borderColor, widgetChild}) =>
    Container(
      width: width,
      height: height,
      alignment: Alignment.topLeft,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderColor == null ? 0 : 2,
        ),
      ),
      child: widgetChild,
    );

Widget addNoteHeader(Note note) => Row(
      children: [
        Expanded(
          child: TextField(
            decoration: new InputDecoration(
              isDense: true,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: HexColor(
                        note.cardBorderColor ?? note.cardForgroundColor)),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: HexColor(
                        note.cardBorderColor ?? note.cardForgroundColor)),
              ),
            ),
            style: TextStyle(color: HexColor(note.cardForgroundColor)),
          ),
        ),
        Container(
          child: IconButton(
            alignment: Alignment.centerRight,
            icon: Icon(Icons.lock_open_outlined),
            onPressed: () {},
            color: HexColor(note.cardForgroundColor),
          ),
        )
      ],
    );
