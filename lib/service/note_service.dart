import 'package:my_note/dao/note_dao.dart';
import 'package:my_note/model/note.dart';

class NoteService {
  static NoteDao _noteDao;

  NoteService() {
    if (_noteDao == null) _noteDao = NoteDao();
  }

  Future<List<Note>> getNotes() async {
    return _noteDao.getAllNotes();
  }

  Future<void> saveNote(Note note) async {
    _noteDao.insertNote(note);
  }

  Future<void> updateNote(Note note) async {
    _noteDao.updateNote(note);
  }

  Future<void> deleteNote(int id) async {
    _noteDao.deleteNote(id);
  }

}
