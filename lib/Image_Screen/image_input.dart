import 'package:car_rental_admin/Image_Screen/image_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  ImageInput({super.key, required this.onSelectedImage});

  final Function(List<String> url) onSelectedImage;

  @override
  State<StatefulWidget> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _takenImage;
  var _isSelected = false;
  List<XFile> _imageFileList = [];
  List<String> _arrImagesUrl = [];

  // This is the Function for Taking the car of the image
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final List<XFile> selectedImage = await imagePicker.pickMultiImage();

    if (selectedImage.isNotEmpty) {
      setState(() {
        _imageFileList.addAll(selectedImage);
      });
    }

    // setState(() {
    //   _takenImage = File(selectedImage!.path);
    // });

    // if (selectedImage!.path.isNotEmpty) {
    //   _imageFileList!.add(_takenImage!);
    // }
    // Conversion from XFile to File.
    // setState(() {
    //   _takenImage = File(imagepicker.);
    // });
  }

  void uploadFunction(List<XFile> _image) async {
    for (int i = 0; i < _image.length; i++) {
      var imageUrl = await uploadFile(_image[i]);

      _arrImagesUrl.add(imageUrl.toString());
    }
    widget.onSelectedImage(_arrImagesUrl);
  }

  Future<String> uploadFile(XFile _images) async {
    final storageref =
        FirebaseStorage.instance.ref().child("Car_Images").child(_images.name);
    await storageref.putFile(File(_images.path));
    return await storageref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height * 0.50,
      decoration: BoxDecoration(
        border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          OutlinedButton(
              onPressed: _takePicture, child: const Text('Select Image')),
          const SizedBox(
            height: 5,
          ),
          Expanded(child: ImageDisplay(imageFileList: _imageFileList)),
          OutlinedButton(
              onPressed: () {
                uploadFunction(_imageFileList);
              },
              child: const Text('Upload')),
        ],
      ),
    );
  }
}
