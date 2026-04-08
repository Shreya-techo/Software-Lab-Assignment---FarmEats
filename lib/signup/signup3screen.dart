import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:new_assignment/signup/signup4screen.dart';
import 'package:new_assignment/signup/signup_model.dart';

class VerificationScreen extends StatefulWidget {
  final SignupData data;
  const VerificationScreen({super.key, required this.data});

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final ImagePicker _picker = ImagePicker();

  File? _image;
  XFile? _pickedFile;
  String? _pdfName;

  Future<void> _pickImage(ImageSource source) async {
    final picked = await _picker.pickImage(source: source);

    if (picked != null) {
      setState(() {
        _pickedFile = picked;
        _pdfName = null;

        if (!kIsWeb) {
          _image = File(picked.path);
        }
      });
    }
  }

  Future<void> pickPDF() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true,
      );

      if (result != null) {
        final file = result.files.single;

        print("File picked: ${file.name}");

        if (kIsWeb) {
          setState(() {
            _pdfName = file.name;
            _pickedFile = null;
            _image = null;
          });
        } else {
          setState(() {
            _image = File(file.path!);
            _pickedFile = null;
            _pdfName = file.name;
          });
        }
      } else {
        print("User cancelled picker");
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  void _handleContinue() {
    if (_pickedFile == null && _image == null && _pdfName == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please upload document")));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BusinessHours(data: widget.data)),
    );
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text("Upload PDF"),
              onTap: () {
                Navigator.pop(context);
                pickPDF();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeFile() {
    setState(() {
      _image = null;
      _pickedFile = null;
      _pdfName = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3ECEA),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height * 0.75,
            ),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("FarmerEats"),

                const SizedBox(height: 30),

                const Text(
                  "Signup 3 of 4",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Verification",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Attach proof of Department of Agriculture registrations",
                  style: TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Attach proof of registration"),
                    GestureDetector(
                      onTap: _showPickerOptions,
                      child: const CircleAvatar(
                        backgroundColor: Color(0xFFD56B55),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                if (_pickedFile != null)
                  kIsWeb
                      ? Image.network(_pickedFile!.path, height: 120)
                      : Image.file(_image!, height: 120),

                if (_pdfName != null)
                  Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.grey.shade200,
                    child: Row(
                      children: [
                        const Icon(Icons.picture_as_pdf),
                        const SizedBox(width: 10),
                        Expanded(child: Text(_pdfName!)),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: _removeFile,
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 300),

                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFD56B55),
                      ),
                      onPressed: _handleContinue,
                      child: const Text(
                        "Continue",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
