class MoodModel {
  final String id;
  final String tanggal;
  final String mood;
  final String catatan;

  MoodModel({
    required this.id,
    required this.tanggal,
    required this.mood,
    required this.catatan,
  });

  factory MoodModel.fromMap(Map<String, dynamic> data, String id) {
    return MoodModel(
      id: id,
      tanggal: data['tanggal'] ?? '',
      mood: data['mood'] ?? '',
      catatan: data['catatan'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tanggal': tanggal,
      'mood': mood,
      'catatan': catatan,
    };
  }
}
