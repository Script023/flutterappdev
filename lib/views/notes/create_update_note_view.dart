import 'package:flutter/material.dart';
import 'package:flutterappdev/services/auth/auth_service.dart';
import 'package:flutterappdev/services/crud/note_services.dart';
import 'package:flutterappdev/utilities/generics/get_arguments.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({super.key});

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  DatabaseNote? _note;
  late final NotesService _noteService;
  late final TextEditingController _textController;
  @override
  void initState() {
    super.initState();
    _noteService = NotesService();
    _textController = TextEditingController();
    _setupTextControllerListener(); // attach listener right away
  }

  // textEditingcontroller ia like a bridge between the textfield and the code
  //_textControllerListener is a function that listens to changes in the textfield and updates the note in the database accordingly
  // _setupTextControllerListener is a function that sets up the listener for the text controller and ensures that there are no duplicate listeners attached to the text controller
  void _setupTextControllerListener() {
    _textController.addListener(_textControllerListener);
  }

  void _textControllerListener() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _noteService.updateNote(note: note, text: text);
  }

  Future<DatabaseNote> createOrGetEXistingNote(BuildContext context) async {
    final widgetNote = context.getArguement<DatabaseNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }
    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }
    //to create a newnote you must have a new user
    // normally the null invocation at the current user can make the app crash
    // but its likely impossible that you will end up here if you are not a user
    //because you must have logged in and registered
    final currentUser = Authservice.firebase().currentUser!;
    final email = currentUser.email;
    final owner = await _noteService.getUser(email: email);
    final newNote = await _noteService.createNote(owner: owner);
    _note = newNote;
    return newNote;
  }

  // we want to make sure that when a user does not type anything after the
  // new note is created that if the user leaves that screen that upon such
  // act that the new empty created note should be deleted
  void _deleteNoteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _noteService.deleteNotes(id: note.id);
    }
  }

  void _saveNoteIfTextNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty) {
      await _noteService.updateNote(note: note, text: text);
    }
  }

  @override
  void dispose() {
    _textController.removeListener(_textControllerListener);
    _saveNoteIfTextNotEmpty();
    _deleteNoteIfTextIsEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New Notes')),
      body: FutureBuilder(
        future: createOrGetEXistingNote(context),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              //snapshot is null at runtime that is why we cannot cast snapshot.data to databasenote directly
              if (!snapshot.hasData || snapshot.data == null) {
                return const Text('Note not found');
              }
              _setupTextControllerListener();
              return TextField(
                controller: _textController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Start typing your note.......',
                ),
              );
            default:
              return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
