import 'package:apple_notes/models/note.dart';
import 'package:apple_notes/models/note_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:provider/provider.dart';

class EditingNotePage extends StatefulWidget {
  Note note;
  bool isNewNote;
  EditingNotePage({
    super.key,
    required this.note,
    required this.isNewNote,
  });

  @override
  State<EditingNotePage> createState() => _EditingNotePageState();
}

class _EditingNotePageState extends State<EditingNotePage> {
  QuillController _controller = QuillController.basic();
  @override
  void initState() {
    super.initState();
    loadExistingNote();
  }

  // load existing note
  void loadExistingNote() {
    final doc = Document()..insert(0, widget.note.text);
    setState(() {
      _controller = QuillController(
          document: doc, selection: const TextSelection.collapsed(offset: 0));
    });
  }

  // add new note
  void addNewNote() {
    //get new id
    int id = Provider.of<NoteData>(context, listen: false).getAllNotes().length;
    //get text from editor
    String text = _controller.document.toPlainText();
    //add the new note
    Provider.of<NoteData>(context, listen: false)
        .addNewNote(Note(id: id, text: text));
  }

  //update existing note
  void updateNote() {
    //get text from editor
    String text = _controller.document.toPlainText();
    //update note
    Provider.of<NoteData>(context, listen: false).updateNote(widget.note, text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemGroupedBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //its a new note
            if (widget.isNewNote && !_controller.document.isEmpty()) {
              addNewNote();
            }

            //it is existing note
            else {
              updateNote();
            }
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          //toolbar
          QuillToolbar.basic(
            controller: _controller,
            showAlignmentButtons: false,
            showBackgroundColorButton: false,
            showCenterAlignment: false,
            showColorButton: false,
            showCodeBlock: false,
            showDirection: false,
            showFontFamily: false,
            showDividers: false,
            showIndent: false,
            showHeaderStyle: false,
            showLink: false,
            showSearchButton: false,
            showInlineCode: false,
            showQuote: false,
            showListNumbers: false,
            showListBullets: false,
            showClearFormat: false,
            showBoldButton: false,
            showFontSize: false,
            showItalicButton: false,
            showUnderLineButton: false,
            showStrikeThrough: false,
            showListCheck: false,
          ),

          //editor
          Expanded(
            child: Container(
              padding: EdgeInsets.all(25),
              child: QuillEditor.basic(
                controller: _controller,
                readOnly: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
