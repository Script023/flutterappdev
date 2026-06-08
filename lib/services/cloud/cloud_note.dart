// there are three properties that a cloud note must contain
// 1. an id primary key that is used to identify the note in the database
// 2. the user id of the owner of the note
// 3. the text of the note
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String text;
  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
  });

  factory CloudNote.fromSnapshot(
    QueryDocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();

    return CloudNote(
      documentId: snapshot.id,
      //Breakpoint of the code
      ownerUserId: data['ownerUserIdFieldName']?.toString() ?? '',
      text: data['textFieldName']?.toString() ?? '',
    );
  }
}
// we do not use the cloud notes constant because we want to be
// able to change the name of the fields in the database without having to
// change the code in the cloud note class the same as the fromrow method
// sqlite