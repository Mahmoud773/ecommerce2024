
import 'dart:io';

import 'package:amazon/consts/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) onPickImage;
  const UserImagePicker({Key? key, required this.onPickImage}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImageFile;
  void _pickImage() async{
   final pickedImage= await ImagePicker().pickImage(source: ImageSource.camera , imageQuality:50 ,
        maxWidth: 150 );
   if(pickedImage == null){
     return;
   }
   setState(() {
     _pickedImageFile=File(pickedImage.path);
   });
   widget.onPickImage(_pickedImageFile!);
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey[400],
          foregroundImage: _pickedImageFile !=null ?  FileImage(_pickedImageFile!):null,
        ),
        MaterialButton(onPressed: _pickImage ,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.image , color: Colors.white,),
              SizedBox(width: 10,),
              Text("Add Image" , style: TextStyle(
                  color: Colors.black
              ),),
            ],
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)),
          color: Colors.grey[400],),
        // TextButton.icon(onPressed: _pickImage, icon: Icon(Icons.image , color: Colors.deepPurpleAccent,),
        //     label: Text("Add Image" ,
        //     style: TextStyle(color: Colors.black),))
      ],
    );
  }
}
