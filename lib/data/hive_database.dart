import 'package:apple_notes/models/note.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  // reference our hive box
  final _myBox = Hive.box('note_database');

  // load note
  List<Note> loadNotes() {
    List<Note> saveNotesFormatted = [];

    //if there exist notes, return that , otherwiese return empty list

    if (_myBox.get("ALL_NOTES") != null) {
      List<dynamic> savedNotes = _myBox.get("ALL_NOTES");
      for (int i = 0; i < savedNotes.length; i++) {
        //created individual note
        Note individualNote =
            Note(id: savedNotes[i][0], text: savedNotes[i][1]);

        //add to list

        saveNotesFormatted.add(individualNote);
      }
    } else {
      //default firs note
      saveNotesFormatted.add(Note(id: 0, text: 'First Note'),);
    }
    return saveNotesFormatted;
  }

  //save notes
  void savedNotes(List<Note> allNotes) {
    List<List<dynamic>> allNotesFormatted = [
      /*

    [
      [0,"first Note"],
      [1,"second Note"],
        ..
    ]
  */
    ];
    //each note has an id and text
    for (var note in allNotes) {
      int id = note.id;
      String text = note.text;
      allNotesFormatted.add([id, text]);
    }
    //then store into hive
    _myBox.put("ALL_NOTES", allNotesFormatted);
  }
}
