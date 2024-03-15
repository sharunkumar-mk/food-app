import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/utils/helpers/common_helpers.dart';

class FirebaseApiServices {
  final FirebaseFirestore firestore;
  FirebaseApiServices(this.firestore);

  createDocument({
    required String collection,
    required Map<String, dynamic> data,
    required String idKey,
    String? id,
  }) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      WriteBatch batch = firestore.batch();

      CollectionReference collectionReference =
          firestore.collection(collection);
      DocumentReference documentReference;

      if (id != null) {
        documentReference = collectionReference.doc(id);
      } else {
        documentReference = collectionReference.doc();
      }

      batch.set(documentReference, data);
      String documentId = documentReference.id;
      if (idKey.isNotEmpty) {
        batch.update(documentReference, {idKey: documentId});
      }
      await batch.commit();
    } catch (e) {
      showLog('Error posting data: $e');
    }
  }

  readCollection({
    required String collection,
    String? id,
  }) async {
    try {
      CollectionReference collectionReference =
          firestore.collection(collection);

      if (id != null) {
        QuerySnapshot snapshot = await collectionReference
            .where(FieldPath.documentId, isEqualTo: id)
            .get();
        if (snapshot.docs.isNotEmpty) {
          final data = snapshot.docs.first.data() as Map<String, dynamic>;
          showLog("$collection DATA ====>>>>>> $data");
          return data;
        } else {
          showLog("$collection with ID $id not found.");
          return null;
        }
      } else {
        QuerySnapshot snapshot = await collectionReference.get();
        final response = snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();

        showLog("RESPONSE ====>>>>>>$response");
        return response;
      }
    } catch (e) {
      showLog("ERROR ====>>>>>>$e");
      return null;
    }
  }

  streamService({required String collection, required String id}) {
    final collectionRef = firestore.collection(collection);
    return collectionRef.doc(id).snapshots();
  }

  readSubcollections({
    required String collectionPath,
    required String subCollectionPath,
    String? id,
  }) async {
    try {
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection(collectionPath);

      QuerySnapshot collectionSnapshot = await collectionRef.get();

      for (QueryDocumentSnapshot doc in collectionSnapshot.docs) {
        CollectionReference subCollectionRef =
            doc.reference.collection(subCollectionPath);
        QuerySnapshot subCollectionSnapshot = await subCollectionRef.get();

        final response = subCollectionSnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
        showLog("RESPONSE ====>>>>>>$response");
        return response;
      }
    } catch (e) {
      showLog('Error reading subcollections: $e');
    }
  }

  getDocument({required String collection, required String documentId}) async {
    final DocumentSnapshot snapshot =
        await firestore.collection(collection).doc(documentId).get();
    return snapshot.data() as Map<String, dynamic>;
  }

  updateDocument(
      String collection, String documentId, Map<String, dynamic> data) async {
    await firestore.collection(collection).doc(documentId).update(data);
  }

  deleteDocument(String collection, String documentId) async {
    await firestore.collection(collection).doc(documentId).delete();
  }
}
