import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
// import 'dart:typed_data';
import 'package:flutter/services.dart';

class NewDataPage extends StatefulWidget {
  @override
  _NewDataPageState createState() => _NewDataPageState();
}

class _NewDataPageState extends State<NewDataPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _priceController = TextEditingController(text: 'Rp. ');
  final _descController = TextEditingController();

  String? _selectedType;
  XFile? _imageFile;
  Uint8List? _imageBytes;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final fileExtension = pickedFile.name.split('.').last.toLowerCase();
      if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
        final bytes = await pickedFile.readAsBytes();
        setState(() {
          _imageFile = pickedFile;
          _imageBytes = bytes;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Format gambar harus jpg, jpeg, atau png')),
        );
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_imageFile == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gambar harus dipilih')),
        );
        return;
      }
      final hargaText = _priceController.text.replaceAll(RegExp(r'[^0-9]'), '');
      final Map<String, dynamic> wisataData = {
        'nama': _nameController.text.trim(),
        'lokasi': _locationController.text.trim(),
        'kategori': _selectedType,
        'harga': int.tryParse(hargaText) ?? 0,
        'deskripsi': _descController.text.trim(),
        'gambar': _imageFile!.name,
        'imageBytes': _imageBytes, 
      };

      print('Data Wisata: $wisataData');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Data berhasil disimpan')),
      );

      Navigator.pop(context,wisataData);
    }
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    _nameController.clear();
    _locationController.clear();
    _priceController.text = 'Rp. ';
    _descController.clear();
    setState(() {
      _selectedType = null;
      _imageFile = null;
      _imageBytes = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE5E5E5), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          'Tambah Wisata',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: _imageBytes != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.memory(_imageBytes!, fit: BoxFit.cover, width: double.infinity),
                        )
                      : Center(child: Icon(Icons.add_a_photo, size: 50, color: Colors.grey)),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D2DA4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _pickImage,
                child: Text('Upload Image', style: TextStyle(color: Colors.white)),
              ),
              _buildLabel("Nama Wisata :"),
              _buildTextField(_nameController, 'Masukkan Nama Wisata Disini'),
              _buildLabel("Lokasi Wisata :"),
              _buildTextField(_locationController, 'Masukkan Lokasi Wisata Disini'),
              _buildLabel("Jenis Wisata :"),
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: ['Pantai', 'Pegunungan', 'Taman', 'Kota']
                    .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                decoration: _inputDecoration("Pilih Jenis Wisata"),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value;
                  });
                },
                validator: (value) => value == null ? 'Pilih jenis wisata' : null,
              ),
              _buildLabel("Harga Tiket :"),
              TextFormField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration("Masukkan Harga Tiket Disini"),
                validator: (value) {
                  final text = value?.replaceAll(RegExp(r'[^0-9]'), '');
                  if (text == null || text.isEmpty) {
                    return 'Harga wajib diisi';
                  } else if (int.tryParse(text) == null) {
                    return 'Harga harus angka';
                  }
                  return null;
                },
                inputFormatters: [
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    if (!newValue.text.startsWith('Rp. ')) {
                      return oldValue;
                    }
                    return newValue;
                  }),
                ],
              ),
              _buildLabel("Deskripsi :"),
              TextFormField(
                controller: _descController,
                decoration: _inputDecoration("Masukkan Deskripsi Disini"),
                maxLines: 3,
                validator: (value) => value!.trim().isEmpty ? 'Deskripsi wajib diisi' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF2D2DA4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: _submitForm,
                child: Text('Simpan', style: TextStyle(color: Colors.white)),
              ),
              Center(
                child: TextButton(
                  onPressed: _resetForm,
                  child: Text('Reset', style: TextStyle(color: Colors.blue)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 4),
      child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    return TextFormField(
      controller: controller,
      decoration: _inputDecoration(hint),
      validator: (value) => value!.trim().isEmpty ? 'Wajib diisi' : null,
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.transparent),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }
}
