import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screen/note_add.dart';
import 'screen/note_detail.dart';
import 'screen/note_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Note',
      initialRoute: HomePage.routeName,
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
          bodyText1: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          foregroundColor: Colors.white,
          backwardsCompatibility: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black12,
            statusBarIconBrightness: Brightness.light,
          ),
          textTheme: const TextTheme(
              title: const TextStyle(color: Colors.white, fontSize: 20)),
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
