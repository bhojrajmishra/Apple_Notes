import 'package:apple_notes/models/note.dart';
import 'package:apple_notes/models/note_data.dart';
import 'package:apple_notes/pages/editing_note_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<NoteData>(context, listen: false).initailizeNotes();
  }

  //create a new note
  void createNewNote() {
    //create a new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;

    //create a blank note

    Note newNote = Note(
      id: id,
      text: '',
    );
    //go to edit the notes
    gotToNotePage(newNote, true);
  }

//go to note editing page
  void gotToNotePage(Note note, bool isNewNote) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditingNotePage(
            note: note,
            isNewNote: isNewNote,
          ),
        ));
  }

  //delte note
  void deleteNote(Note note) {
    Provider.of<NoteData>(context, listen: false).deleteNote(note);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: createNewNote,
          elevation: 0,
          backgroundColor: Colors.grey[300],
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 50),
              child: Text(
                'Notes',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Center(
                child: Container(
                 width: 300,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'search...',
                      border: InputBorder.none,
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),

            //list of notes

            value.getAllNotes().length == 0
                ? Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Center(
                      child: Text(
                        'Nothing here...',
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  )
                : CupertinoListSection.insetGrouped(
                    children: List.generate(
                      value.getAllNotes().length,
                      (index) => CupertinoListTile(
                        title: Text(value.getAllNotes()[index].text),
                        onTap: () =>
                            gotToNotePage(value.getAllNotes()[index], false),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              deleteNote(value.getAllNotes()[index]),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
