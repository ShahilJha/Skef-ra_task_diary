import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:skefra_task_diary/domain/auth/i_auth_facade.dart';
import 'package:skefra_task_diary/domain/core/errors/not_authenticated_error.dart';
import 'package:skefra_task_diary/injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = await getIt<IAuthFacade>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticateError());
    return getIt<FirebaseFirestore>()
        .collection('users')
        .doc(user.id.getOrCrash());
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference get noteCollection => collection('notes');
}
