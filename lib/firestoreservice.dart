import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'task.dart';

final CollectionReference myCollection =
    Firestore.instance.collection('driver');

final CollectionReference myCollection1 = Firestore.instance.collection('user_location2');

class FirestoreService {
  Future<Task> createTODOTask(String email, String SunToMon
      /*,Uri images*/) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection.document());
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData) {
      return Task.fromMap(mapData);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getTaskList({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = myCollection.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}

class FirestoreService1 {
  Future<Task> createTODOTask(String email, String SunToMon
      ,Uri userLocation) async {
    final TransactionHandler createTransaction = (Transaction tx) async {
      final DocumentSnapshot ds = await tx.get(myCollection1.document());
    };

    return Firestore.instance.runTransaction(createTransaction).then((mapData2) {
      return Task.fromMap(mapData2);
    }).catchError((error) {
      print('error: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getTaskList2({int offset, int limit}) {
    Stream<QuerySnapshot> snapshots = myCollection1.snapshots();

    if (offset != null) {
      snapshots = snapshots.skip(offset);
    }
    if (limit != null) {
      snapshots = snapshots.take(limit);
    }
    return snapshots;
  }
}
