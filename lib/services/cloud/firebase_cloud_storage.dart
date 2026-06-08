import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterappdev/services/auth/auth_service.dart';
import 'package:flutterappdev/services/cloud/cloud_note.dart';
import 'package:flutterappdev/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection('notes');

  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
      notes.snapshots().map(
        (event) => event.docs
            .map((doc) => CloudNote.fromSnapshot(doc))
            .where((note) => note.ownerUserId == ownerUserId),
      );
  Future<void> deleteNote({required String documentId}) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      await notes.doc(documentId).update({'textFieldName': text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          .where('ownerUserIdFieldName', isEqualTo: ownerUserId)
          .get()
          .then(
            (value) =>
                value.docs.map((doc) => CloudNote.fromSnapshot(doc)).toList(),
          );
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  Future<CloudNote> createNewNote({required String ownerUserId}) async {
    final document = await notes.add({
      'ownerUserIdFieldName': ownerUserId,
    });
    final currentUser = Authservice.firebase().currentUser!;
    final userId = currentUser.id;
    final fetchNote = await document.get();
    return CloudNote(
      documentId: fetchNote.id,
      ownerUserId: userId,
      text: '',
    );
  }

  static final firebaseCloudStorageShared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => firebaseCloudStorageShared;
}
