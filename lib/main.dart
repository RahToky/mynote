import 'package:flutter/material.dart';
import 'package:my_note/page/note_list.dart';
import 'package:my_note/page/note_add.dart';
import 'package:my_note/page/note_detail.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Note',
      initialRoute: HomePage.routeName,//HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        NoteAddPage.routeName: (context) => NoteAddPage(),
        NoteDetailPage.routeName: (context) => NoteDetailPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.white,
        backgroundColor: Colors.black26,
        accentColor: Colors.lightBlueAccent,
        buttonColor: Colors.purple,
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Colors.blueGrey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          foregroundColor: Colors.white,
          textTheme: TextTheme(
            title: TextStyle(color: Colors.white, fontSize: 20)
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            primary: Colors.white,
            backgroundColor: Colors.lightBlueAccent,
          ),
        ),
      ),
    );
  }
}
