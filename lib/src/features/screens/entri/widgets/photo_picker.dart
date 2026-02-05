import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:welangflood/src/constants/color.dart';

class PhotoPicker extends StatefulWidget {
  final String hintText;
  final bool isRequired;
  final TextEditingController? controller;
  final bool isValid;
  final Function(String)? onPhotoSelected;

  const PhotoPicker({
    Key? key,
    required this.hintText,
    required this.isRequired,
    this.controller,
    required this.isValid,
    this.onPhotoSelected,
  }) : super(key: key);

  @override
  _PhotoPickerState createState() => _PhotoPickerState();
}

class _PhotoPickerState extends State<PhotoPicker> {
  XFile? _pickedFile;

  Future<void> _pickFile() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _pickedFile = pickedFile;
          widget.controller?.text = pickedFile.path;
          widget.onPhotoSelected?.call(pickedFile.path);
        });
      }
    } catch (e) {
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Failed to pick image. Please try again later.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width >= 375 ? 375 : screenSize.width - 30,
      height: 83,
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hintText,
            style: const TextStyle(
              color: tPrimaryColor,
              fontSize: 16,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: screenSize.height * 0.01),
          Container(
            decoration: BoxDecoration(
              color: widget.isValid ? const Color(0xFFF9FAFB) : Colors.redAccent,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: tPrimaryColor),
            ),
            child: Center(
              child: _pickedFile != null
                  ? Image.file(File(_pickedFile!.path))
                  : IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: _pickFile,
                color: tPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

