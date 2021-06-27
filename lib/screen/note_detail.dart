import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_note/callback/icon_callback.dart';
import 'package:my_note/const/strings.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/screen/dialog/confirm_dialog.dart';
import 'package:my_note/service/note_service.dart';
import 'package:my_note/util/color_util.dart';

import 'include/app_bar_detail.dart';
import 'include/note_card.dart';
import 'note_add.dart';

class NoteDetailScreen extends StatefulWidget {
  static const routeName = "/detail";

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen>
    implements IconClickListener {
  final NoteService _noteService = NoteService();
  Note _note;
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    final arguments = ModalRoute.of(context).settings.arguments as Map;
    if (arguments != null) _note = arguments['note'];
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: MyAppBarDetail(this),
      body: Container(
        width: size.width,
        height: size.height - kToolbarHeight * 2,
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: HexColor(_note.cardBackgroundColor),
          border: Border.all(
            color: _note.cardBorderColor == null
                ? Colors.transparent
                : HexColor(_note.cardBorderColor),
            width: _note.cardBorderColor == null ? 0 : 2,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cardTitle(_note, 24),
              const Divider(
                height: 20,
                color: Colors.white70,
              ),
              Text(
                '${_note.content}',
                style: TextStyle(
                  fontSize: 16,
                  color: HexColor(_note.cardForegroundColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onIconClick(String tag) {
    if (tag.compareTo(MyAppBarDetail.delTag) == 0) {
      showDialog(
        context: context,
        builder: (context) {
          return ConfirmDialog(context);
        },
      ).then(
        (value) {
          if (value) {
            _deleteNote();
            _finish();
          }
          return;
        },
      );
    } else if (tag.compareTo(MyAppBarDetail.editTag) == 0) {
      Navigator.of(context).pushNamed(NoteAddScreen.routeName,
          arguments: {'note': _note}).then((value) {
        setState(() {});
      });
    }
  }

  void _finish() {
    if (Navigator.canPop(_context)) {
      Navigator.pop(_context);
    } else {
      SystemNavigator.pop();
    }
  }

  void _deleteNote() async {
    try {
      await _noteService.deleteNote(_note.id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              const SizedBox(width: 5),
              Text('$kNoteRemoved'),
            ],
          ),
          duration: Duration(milliseconds: 2000),
        ),
      );
    } catch (e) {}
  }
}
