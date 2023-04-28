import 'package:birds_weights/models/weight_day.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class DatabaseService {
  static final DatabaseService _database = DatabaseService._();

  DatabaseService._();

  factory DatabaseService() {
    return _database;
  }

  // collection reference
  final CollectionReference _weightsCollection =
      FirebaseFirestore.instance.collection('weigths');

  //create or update weights data of thtat date
  Future updateWeightsData(WeightDay data) async {
    return await _weightsCollection
        .doc(getUidFromDateTime(data.date))
        .set(data.weights);
  }

  //get stream
  Stream<List<WeightDay>> get weights {
    return _weightsCollection.snapshots().map(_weightListFromSnapshot);
  }

  // weight list from snapshot
  List<WeightDay> _weightListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map(_weightDayFromDoc).toList();
  }

  WeightDay _weightDayFromDoc(QueryDocumentSnapshot doc) {
    var w = WeightDay.empty();

    if (doc.data() != null) {
      var data = Map<String, int>.from(doc.data() as Map<String, dynamic>);

      if (makeNamesCompleted(data)) {
        w = WeightDay(getDateTimeFromUid(doc.id), data);
      } else {
        if (kDebugMode) {
          print("**** Chyba v prijatych datech. Nesedi jmena.");
        }
      }
    }
    return w;
  }
}
