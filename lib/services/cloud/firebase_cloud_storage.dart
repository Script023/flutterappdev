import 'package:cloud_firestore/cloud_firestore.dart';
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
            (value) => value.docs
                .map(
                  (doc) => CloudNote(
                    documentId: doc.id,
                    ownerUserId: doc.data()['ownerUserIdFieldName'] as String,
                    text: doc.data()['textFieldName'] as String,
                  ),
                )
                .toList(),
          );
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  void createNewNote({required String ownerUserId}) async {
    await notes.add({'ownerUserIdFieldName': ownerUserId, 'textFieldName': ''});
  }

  static final firebaseCloudStorageShared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => firebaseCloudStorageShared;
}
