import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_note/const/strings.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/page/include/app_bar_list.dart';
import 'package:my_note/service/note_service.dart';

import 'include/note_card.dart';
import 'note_add.dart';

class HomePage extends StatefulWidget {
  static const routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _scrollController = ScrollController();
  final NoteService _noteService = NoteService();
  List<Note> notes;
  bool showLogo = true;

  @override
  void initState() {
    super.initState();
    notes = [];
    fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            MySliverAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Dismissible(
                    behavior: HitTestBehavior.deferToChild,
                    key: UniqueKey(),
                    child: (index < notes.length - 1)
                        ? NoteCard(notes[index])
                        : Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            child: NoteCard(notes[index]),
                          ),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 10),
                      margin: EdgeInsets.only(
                          top: 10, bottom: (index < notes.length - 1) ? 0 : 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            kDeletion,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    direction: DismissDirection.startToEnd,
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return confirmDialog(context, index);
                        },
                      );
                    },
                  );
                },
                childCount: notes.length,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, NoteAddPage.routeName).then((value) {
              setState(() {
                fetchNotes();
              });
            });
          },
        ),
      ),
    );
  }

  void fetchNotes() async {
    notes = await _noteService.getNotes();
    setState(() {});
  }

  void deleteNote(id) async {
    await _noteService.deleteNote(id);
  }

  AlertDialog confirmDialog(context, id) => AlertDialog(
        title: Text(kConfirm),
        content: Text(kAUsureToDel),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(kCancel),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey,
            ),
          ),
          TextButton(
            onPressed: () => {
              Navigator.of(context).pop(true),
              deleteNote(id),
            },
            child: Text(kRemove),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      );
}
