import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import 'package:favorite_places/widgets/widgets/styles/common_styles.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({
    super.key,
    required this.onImageSelected,
  });

  final void Function(File? image) onImageSelected;

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  final ImagePicker _picker = ImagePicker();
  File? _pickedImage;

  void _saveImage() async {
    final pickedImg = await _picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImg != null) {
      setState(() {
        _pickedImage = File(pickedImg.path);
      });
      widget.onImageSelected(_pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: _pickedImage != null
          ? GestureDetector(
              onTap: _saveImage,
              child: Image.file(
                _pickedImage!,
                fit: BoxFit.contain,
              ),
            )
          : TextButton.icon(
              onPressed: _saveImage,
              icon: const Icon(
                Icons.camera_rounded,
              ),
              label: Text(
                'Take Picture',
                style: cmnLetterSpacing,
              ),
              style: const ButtonStyle(
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                )),
              ),
            ),
    );
  }
}
