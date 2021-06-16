import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_note/const/strings.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/page/note_add.dart';
import 'package:my_note/service/note_service.dart';

import 'include/app_bar.dart';
import 'include/note_card.dart';
import 'note_add_2.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  static const routeName = "/";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  /*
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setState(() {

      });
    }
  }*/

  final NoteService _noteService = NoteService();
  ScrollController _scrollController = ScrollController();
  bool showLogo = true;
  List<Note> notes;
  var top = 0.0;

  @override
  void initState() {
    super.initState();
    fetchNotes();
    /*_scrollController.addListener(() {
      if (_isAppBarExpanded && showLogo) {
        showLogo = false;
        setState(() {});
      } else if (!_isAppBarExpanded && !showLogo) {
        showLogo = true;
        setState(() {});
      }
    });*/
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  void fetchNotes() async {
    notes = await _noteService.getNotes();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: size.height * 0.3,
            backgroundColor: Colors.black,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                top = constraints.biggest.height;
                final _iconSize = top*45/235;
                return FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                  title: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (top > 100)
                          Icon(
                            Icons.file_copy_outlined,
                            color: Colors.white,
                            size: _iconSize,
                          ),
                        const SizedBox(height: 10),
                        Text(
                          kAppName,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  background: Container(
                    color: Colors.black26,
                  ),
                );
              },
            ),
            actions: [
              PopupMenuButton(
                //don't specify icon if you want 3 dot menu
                itemBuilder: (context) => [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      kAbout,
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      'Help',
                      style: const TextStyle(color: Colors.black87),
                    ),
                  ),
                ],
                onSelected: (item) => {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const AboutDialog();
                      }),
                },
              ),
            ],
          ),
          SliverFixedExtentList(
            itemExtent: 128.0,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                Note note = notes[index];
                return Dismissible(
                  key: UniqueKey(),
                  child: (index < notes.length - 1)
                      ? NoteCard(note)
                      : Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: NoteCard(note),
                        ),
                  onDismissed: (direction) {
                    notes.remove(note);
                    deleteNote(note.id.toInt());
                  },
                );
              },
              childCount: notes == null ? 0 : notes.length,
              addRepaintBoundaries: true,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: Theme.of(context).accentColor,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, NoteAddPage2.routeName).then((value) {
            setState(() {});
          });
        },
      ),
    );
  }

  void deleteNote(id) async {
    await _noteService.deleteNote(id);

  }
}
