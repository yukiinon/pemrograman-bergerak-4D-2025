import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/mood_model.dart';

class MoodService {
  final CollectionReference _moodRef = FirebaseFirestore.instance.collection('mood_journal');

  Stream<List<MoodModel>> getMoods() {
    return _moodRef.orderBy('tanggal').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return MoodModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    });
  }

  Future<void> addMood(MoodModel mood) {
    return _moodRef.add(mood.toMap());
  }

  Future<void> updateMood(MoodModel mood) {
    return _moodRef.doc(mood.id).update(mood.toMap());
  }

  Future<void> deleteMood(String id) {
    return _moodRef.doc(id).delete();
  }
}
