import 'package:apple_notes/data/hive_database.dart';
import 'package:apple_notes/models/note.dart';
import 'package:flutter/material.dart';
import 'note.dart';

class NoteData extends ChangeNotifier {
  //hive database
  final db = HiveDatabase();
  //overall list of notes
  List<Note> allNotes = [
   
  ];
//initailize list
  void initailizeNotes() {
    allNotes = db.loadNotes();
  }

  // get notes
  List<Note> getAllNotes() {
    return allNotes;
  }

  //add a new note
  void addNewNote(Note note) {
    allNotes.add(note);
    notifyListeners();
  }

  //update note
  void updateNote(Note note, String text) {
    for (int i = 0; i < allNotes.length; i++) {
      if (allNotes[i].id == note.id) {
        //replace text
        allNotes[i].text = text;
      }
    }
    notifyListeners();
  }

  //delete note
  void deleteNote(Note note) {
    allNotes.remove(note);
    notifyListeners();
  }
}
