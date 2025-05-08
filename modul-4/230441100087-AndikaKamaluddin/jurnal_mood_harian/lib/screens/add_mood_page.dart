import 'package:flutter/material.dart';
import '../models/mood_model.dart';
import '../services/mood_service.dart';

class AddMoodPage extends StatefulWidget {
  final MoodModel? mood;

  const AddMoodPage({super.key, this.mood});

  @override
  _AddMoodPageState createState() => _AddMoodPageState();
}

class _AddMoodPageState extends State<AddMoodPage> {
  final _tanggalController = TextEditingController();
  final _catatanController = TextEditingController();
  final MoodService _service = MoodService();

  String _selectedMood = '😄';

  final List<String> moods = ['😄', '😊', '😔', '😡', '😴', '😍', '😭', '😎', '🤯', '🤗', '😤', '😬', '🫠', '😇'];

  @override
  void initState() {
    super.initState();
    if (widget.mood != null) {
      _tanggalController.text = widget.mood!.tanggal;
      _catatanController.text = widget.mood!.catatan;
      _selectedMood = widget.mood!.mood;
    }
  }

  void _saveMood() async {
    final tanggal = _tanggalController.text;
    final catatan = _catatanController.text;

    if (tanggal.isEmpty || catatan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tanggal dan catatan harus diisi!')),
      );
      return;
    }

    final newMood = MoodModel(
      id: widget.mood?.id ?? '',
      tanggal: tanggal,
      mood: _selectedMood,
      catatan: catatan,
    );

    if (widget.mood == null) {
      await _service.addMood(newMood);
    } else {
      await _service.updateMood(newMood);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.mood == null ? 'Tambah Mood' : 'Edit Mood')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _tanggalController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal (YYYY-MM-DD)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedMood,
                decoration: const InputDecoration(
                  labelText: 'Pilih Mood',
                  border: OutlineInputBorder(),
                ),
                items: moods.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                onChanged: (value) => setState(() => _selectedMood = value!),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _catatanController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'Catatan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveMood,
                child: Text(widget.mood == null ? 'Simpan Mood' : 'Update Mood'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15), backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
