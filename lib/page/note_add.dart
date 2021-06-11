import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_note/const/colors.dart';
import 'package:my_note/const/strings.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/service/note_service.dart';
import 'package:my_note/util/color_util.dart';

class NoteAddPage extends StatefulWidget {
  static const routeName = "/add";

  @override
  _NoteAddPageState createState() => _NoteAddPageState();
}

class _NoteAddPageState extends State<NoteAddPage> {
  final double spacing = 20.0;
  final NoteService _noteService = NoteService();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  final List<Map<String, String>> hexColors = MyColors.getHexMapColors();
  int selectedThemeId = 0;
  bool isChoosing = true;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(elevation: 0),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: size.height - kToolbarHeight*3+10 - 20,
              padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$kTheme :',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: hexColors.map((color) {
                        final itemId = int.parse(color['id']);
                        return GestureDetector(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            height: 50,
                            width: isChoosing
                                ? 50
                                : (itemId == selectedThemeId)
                                    ? size.width -20
                                    : 0,
                            decoration: BoxDecoration(
                                color: HexColor(color['cardBackgroundColor']),
                                border: Border.all(
                                    color: HexColor(
                                        color['cardBorderColor'] ?? "#ffffff"),
                                    width: (color['cardBorderColor'] == null)
                                        ? 0
                                        : 1)),
                          ),
                          onTap: () {
                            setState(() {
                              selectedThemeId = itemId;
                              isChoosing = !isChoosing;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "$kTitle :",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: _titleController,
                    maxLines: 1,
                    decoration: new InputDecoration(
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Theme.of(context).accentColor)),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Theme.of(context).accentColor)),
                    ),
                  ),
                  SizedBox(height: spacing),
                  Text(
                    "$kContent :",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  SizedBox(height: 5),
                  TextField(
                    controller: _contentController,
                    maxLines: 10,
                    keyboardType: TextInputType.multiline,
                    decoration: new InputDecoration(
                      isDense: true,
                      focusedBorder: OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Theme.of(context).accentColor)),
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Theme.of(context).accentColor)),
                    ),
                  ),
                  SizedBox(height: 20),

                ],
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
            )
          ],
        ),
      ),
    );
  }

  void saveNote(context) async {
    Note note = Note(
      title: _titleController.text,
      content: _contentController.text,
      cardBackgroundColor: hexColors[selectedThemeId]['cardBackgroundColor'],
      cardForgroundColor: hexColors[selectedThemeId]['cardForgroundColor'],
      cardBorderColor: hexColors[selectedThemeId]['cardBorderColor'],
      isLocked: 0,
    );
    await _noteService.saveNote(note);
    Navigator.pop(context);
  }
}
