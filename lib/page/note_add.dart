import 'package:flutter/material.dart';
import 'package:my_note/const/colors.dart';
import 'package:my_note/const/strings.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/service/note_service.dart';
import 'package:my_note/util/color_util.dart';

import 'include/app_bar_add.dart';

class NoteAddPage extends StatefulWidget {
  static const routeName = "/add2";

  @override
  _NoteAddPageState createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  Note note;
  final NoteService _noteService = NoteService();
  final List<Map<String, String>> hexColors = MyColors.getHexMapColors();

  TextEditingController _titleController;
  TextEditingController _contentController;
  bool focusContent = false;
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
  void initState() {
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    initNote(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyAppBarAdd(isEditing ? kEdit : kNew, note.cardBackgroundColor),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            createBox(
              height: size.height - 10 - kToolbarHeight * 3,
              width: size.width,
              backgroundColor: HexColor(note.cardBackgroundColor),
              borderColor: note.cardBorderColor == null
                  ? Colors.transparent
                  : HexColor(note.cardBorderColor),
              widgetChild: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 30,
                      child: TextField(
                        autofocus: true,
                        onTap: () {
                          focusContent = false;
                        },
                        controller: _titleController,
                        maxLines: 1,
                        decoration: new InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: '$kTitle....',
                            hintStyle: TextStyle(
                              color: HexColor(note.cardForgroundColor),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            )),
                        style: TextStyle(
                            color: HexColor(note.cardForgroundColor),
                            fontSize: 24),
                      ),
                    ),
                    Divider(
                        height: 1, color: HexColor(note.cardForgroundColor)),
                    InkWell(
                      onTap: () {
                        setState(() {
                          focusContent = true;
                        });
                      },
                      child: Container(
                        height: size.height * 0.66,
                        child: TextField(
                          autofocus: focusContent,
                          controller: _contentController,
                          maxLines: null,
                          decoration: new InputDecoration(
                              isDense: true,
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: '$kDescription....',
                              hintStyle: TextStyle(
                                color: HexColor(note.cardForgroundColor),
                              )),
                          style: TextStyle(
                              color: HexColor(note.cardForgroundColor)),
                        ),
                      ),
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
    note.title = _titleController.text;
    note.content = _contentController.text;
    note.cardBackgroundColor = hexColors[2]['cardBackgroundColor'];
    note.cardForgroundColor = hexColors[2]['cardForgroundColor'];
    note.cardBorderColor = hexColors[2]['cardBorderColor'];
    note.isLocked = 0;
    await _noteService.saveNote(note);
    Navigator.pop(context);
  }
}

Container createBox(
        {height, width, backgroundColor, borderColor, widgetChild}) =>
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
