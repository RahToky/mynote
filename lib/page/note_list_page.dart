import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_note/model/note.dart';
import 'package:my_note/page/note_add.dart';
import 'package:my_note/service/note_service.dart';

import 'include/app_bar.dart';
import 'include/note_card.dart';
import 'note_add_2.dart';

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: MyAppBar(),
        body: FutureBuilder<List<Note>>(
          future: NoteService().getNotes(), // async work
          builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: Text('Chargement....'));
              default:
                if (snapshot.hasError)
                  return Text('Error: ${snapshot.error}');
                else {
                  List<Note> notes = snapshot.data;
                  return (notes != null && notes.length>0)?
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: notes.length,
                    itemBuilder: (context, i) {
                      final item = notes[i];
                      return Dismissible(
                        key: UniqueKey(),
                        child: (i < notes.length-1)?NoteCard(item):Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: NoteCard(item),
                        ),
                        onDismissed: (direction) {
                            notes.remove(item);
                            deleteNote(item.id.toInt());
                        },
                      );
                    },
                  ):Center(child: Text("aucun note"),);
                }
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          backgroundColor: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pushNamed(context, NoteAddPage2.routeName).then((value) {
              setState((){});
            });
          },
        ),
      ),
    );
  }

  void deleteNote(id) async{
    await _noteService.deleteNote(id);
  }
}

