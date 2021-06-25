import 'package:flutter/material.dart';
import 'package:my_note/model/card_color.dart';

class Note {
  int id;
  String title;
  String content;
  int isLocked;
  String cardBackgroundColor;
  String cardForegroundColor;
  String cardBorderColor;
  int firstIconCodePoint;
  int secondIconCodePoint;

  Note(
      {this.id,
      this.title,
      this.content,
      this.isLocked,
      this.cardBackgroundColor,
      this.cardForegroundColor,
      this.cardBorderColor,
      this.firstIconCodePoint,
      this.secondIconCodePoint});

  factory Note.fromDB(Map<String, dynamic> map) {
    return Note(
        id: map['id'],
        title: map['title'],
        content: map['content'],
        cardForegroundColor: map['cardForegroundColor'],
        cardBackgroundColor: map['cardBackgroundColor'],
        cardBorderColor: map['cardBorderColor'],
        firstIconCodePoint: map['firstIconCodePoint'],
        secondIconCodePoint: map['secondIconCodePoint'],
        isLocked: map['isLocked']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': this.title,
      'content': this.content,
      'cardForegroundColor': this.cardForegroundColor,
      'cardBackgroundColor': this.cardBackgroundColor,
      'cardBorderColor': this.cardBorderColor,
      'firstIconCodePoint': this.firstIconCodePoint,
      'secondIconCodePoint': this.secondIconCodePoint,
      'isLocked': this.isLocked,
    };
  }
}
