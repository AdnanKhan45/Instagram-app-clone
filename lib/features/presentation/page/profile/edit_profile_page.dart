import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_app/consts.dart';
import 'package:instagram_clone_app/features/domain/entities/user/user_entity.dart';
import 'package:instagram_clone_app/features/domain/usecases/firebase_usecases/storage/upload_image_to_storage_usecase.dart';
import 'package:instagram_clone_app/features/presentation/cubit/user/user_cubit.dart';
import 'package:instagram_clone_app/features/presentation/page/profile/widgets/profile_form_widget.dart';
import 'package:instagram_clone_app/profile_widget.dart';
import 'package:instagram_clone_app/injection_container.dart' as di;

class EditProfilePage extends StatefulWidget {
  final UserEntity currentUser;

  const EditProfilePage({Key? key, required this.currentUser}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController? _nameController;
  TextEditingController? _usernameController;
  TextEditingController? _websiteController;
  TextEditingController? _bioController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.currentUser.name);
    _usernameController = TextEditingController(text: widget.currentUser.username);
    _websiteController = TextEditingController(text: widget.currentUser.website);
    _bioController = TextEditingController(text: widget.currentUser.bio);
    super.initState();
  }

  bool _isUpdating = false;

  File? _image;

  Future selectImage() async {
    try {
      final pickedFile = await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);
        } else {
          print("no image has been selected");
        }
      });

    } catch(e) {
      toast("some error occured $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: backGroundColor,
        title: Text("Edit Profile"),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              size: 32,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              onTap: _updateUserProfileData,
              child: Icon(
                Icons.done,
                color: blueColor,
                size: 32,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: profileWidget(imageUrl: widget.currentUser.profileUrl, image: _image),
                  ),
                ),
              ),
              sizeVer(15),
              Center(
                child: GestureDetector(
                  onTap: selectImage,
                  child: Text(
                    "Change profile photo",
                    style: TextStyle(color: blueColor, fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              sizeVer(15),
              ProfileFormWidget(title: "Name", controller: _nameController),
              sizeVer(15),
              ProfileFormWidget(title: "Username", controller: _usernameController),
              sizeVer(15),
              ProfileFormWidget(title: "Website", controller: _websiteController),
              sizeVer(15),
              ProfileFormWidget(title: "Bio", controller: _bioController),
              sizeVer(10),
              _isUpdating == true?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Please wait...", style: TextStyle(color: Colors.white),),
                  sizeHor(10),
                  CircularProgressIndicator()
                ],
              ) : Container(width: 0, height: 0,)
            ],
          ),
        ),
      ),
    );
  }

  _updateUserProfileData() {
    setState(() => _isUpdating = true);
    if (_image == null) {
      _updateUserProfile("");
    } else {
      di.sl<UploadImageToStorageUseCase>().call(_image!, false, "profileImages").then((profileUrl) {
        _updateUserProfile(profileUrl);
      });
    }
  }

  _updateUserProfile(String profileUrl) {

    BlocProvider.of<UserCubit>(context).updateUser(
      user: UserEntity(
        uid: widget.currentUser.uid,
       username: _usernameController!.text,
       bio: _bioController!.text,
       website: _websiteController!.text,
       name: _nameController!.text,
        profileUrl: profileUrl
      )
    ).then((value) => _clear());
  }

  _clear() {
    setState(() {
      _isUpdating = false;
      _usernameController!.clear();
      _bioController!.clear();
      _websiteController!.clear();
      _nameController!.clear();
    });
    Navigator.pop(context);
  }
}
