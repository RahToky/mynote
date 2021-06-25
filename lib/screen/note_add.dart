import 'package:flutter/material.dart';
import 'package:my_note/callback/color_picker_callback.dart';
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

class _NoteAddPageState extends State<NoteAddPage>  implements ColorsPickerListener{

  Note note;
  final NoteService _noteService = NoteService();

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
      setNoteColor("#43474a","#ffffff","#43474a");
    }
  }

  void setNoteColor(String hexForegroundColor, String hexBackgroundColor, String hexBorderColor){
    note.cardForegroundColor = hexForegroundColor;
    note.cardBackgroundColor = hexBackgroundColor;
    note.cardBorderColor = hexBorderColor;
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _contentController = TextEditingController();
  }



  @override
  Widget build(BuildContext context) {
    initNote(context);
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyAppBarAdd(isEditing ? kEdit : kNew, HexColor(note.cardBackgroundColor),HexColor(note.cardForegroundColor),this),
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
                            hintText: '$kTitle...',
                            hintStyle: TextStyle(
                              color: HexColor(note.cardForegroundColor),
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            )),
                        style: TextStyle(
                            color: HexColor(note.cardForegroundColor),
                            fontSize: 20),
                      ),
                    ),
                    Divider(
                        height: 1, color: HexColor(note.cardForegroundColor)),
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
                              hintText: '$kDescription...',
                              hintStyle: TextStyle(
                                color: HexColor(note.cardForegroundColor),
                              )),
                          style: TextStyle(
                              color: HexColor(note.cardForegroundColor)),
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
    note.isLocked = 0;
    try {
      await _noteService.saveNote(note);
      Navigator.pop(context);
    }on Exception catch(e){
      print('error $e');
    }
  }

  @override
  void onPick(Map<String, String> colorMap) {
    setState(() {
      setNoteColor(colorMap['cardForegroundColor'], colorMap['cardBackgroundColor'], colorMap['cardBorderColor']);
    });
  }

  Container createBox(
      {height, width, backgroundColor, borderColor, widgetChild}) =>
      Container(
        width: width,
        height: height,
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
}


