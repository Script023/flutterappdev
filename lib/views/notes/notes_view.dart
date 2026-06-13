import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterappdev/enums/menu_action.dart';
import 'package:flutterappdev/routes.dart';
import 'package:flutterappdev/services/auth/auth_service.dart';
import 'package:flutterappdev/services/auth/bloc/auth_bloc.dart';
import 'package:flutterappdev/services/auth/bloc/auth_event.dart';
import 'package:flutterappdev/services/cloud/cloud_note.dart';
import 'package:flutterappdev/services/cloud/firebase_cloud_storage.dart';
import 'package:flutterappdev/utilities/dailogs/logout_dailog.dart';
import 'package:flutterappdev/views/notes/notes_list_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  // no more user email now using user id
  String get userId => Authservice.firebase().currentUser!.id;
  //late final NotesService _notesService;
  late final FirebaseCloudStorage _noteService;
  @override
  void initState() {
    _noteService = FirebaseCloudStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(createOrUpdateNoteRoute);
            },
            icon: const Icon(Icons.add),
          ),
          PopupMenuButton<MenuAction>(
            //need to understand how to use the onSelected callback to handle menu
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogoutDialog(context);
                  //devtools.log(shouldLogout.toString());
                  //break;
                  if (shouldLogout) {
                    context.read<AuthBloc>().add(AuthEventLogOut());
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Logout'),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _noteService.allNotes(ownerUserId: userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          // if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // return const Center(child: Text("No notes yet"));
          // }
          final allNotes = snapshot.data as Iterable<CloudNote>;
          return NotesListView(
            notes: allNotes.toList(),
            onDeleteNote: (note) async {
              await _noteService.deleteNote(documentId: note.documentId);
            },
            onTap: (note) {
              Navigator.of(
                context,
              ).pushNamed(createOrUpdateNoteRoute, arguments: note);
            },
          );
        },
      ),
    );
  }
}
