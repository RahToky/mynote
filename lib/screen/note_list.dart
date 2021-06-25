import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_note/const/strings.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/service/note_service.dart';

import 'include/app_bar_list.dart';
import 'include/note_card.dart';
import 'note_add.dart';
import 'dart:developer' as developer;

import 'note_detail.dart';

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
                    key: UniqueKey(),
                    behavior: HitTestBehavior.deferToChild,
                    child: (index < notes.length - 1)
                        ? InkWell(
                            child: NoteCard(notes[index]),
                            onTap: () {
                              _openDetailScreen(notes[index]);
                            },
                          )
                        : InkWell(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: NoteCard(notes[index]),
                            ),
                            onTap: () {
                              _openDetailScreen(notes[index]);
                            },
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
                    onDismissed: (direction) {
                      deleteNote((notes[index]).id);
                    },
                    confirmDismiss: (direction) async {
                      return await showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return confirmDialog(context);
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
              fetchNotes();
            });
          },
        ),
      ),
    );
  }

  void fetchNotes() async {
    try {
      notes = await _noteService.getNotes();
      setState(() {});
    } on Exception catch (e) {
      developer.log('error: $e');
    }
  }

  void deleteNote(id) async {
    try {
      await _noteService.deleteNote(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
              const SizedBox(width: 5),
              const Text('Note supprimée'),
            ],
          ),
        ),
      );
    } on Exception catch (e) {
      developer.log('error: $e');
    }
  }

  AlertDialog confirmDialog(context) => AlertDialog(
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
            },
            child: Text(kRemove),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      );

  void _openDetailScreen(note) {
    Navigator.pushNamed(context, NoteDetailPage.routeName,
        arguments: {'note': note}).then((value) {
      fetchNotes();
    });
  }
}
