// ignore_for_file: library_prefixes, deprecated_member_use

import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '/model/model.dart';
import '../../fire_auth/fire_auth.dart';
import '/components/components.dart';

class ProfileBloc extends BaseBloc {
  BehaviorSubject<File> fileIamgeStream = BehaviorSubject();
  BehaviorSubject<Account> accountStream = BehaviorSubject();
  BehaviorSubject<UIState> accountStateStream = BehaviorSubject();

  @override
  void init() {
    _getAccount();
  }

  @override
  void dispose() {
    accountStream.close();
    accountStateStream.close();
    fileIamgeStream.close();
  }

  void _getAccount() async {
    try {
      accountStateStream.add(UIState.LOADING);
      FireAuth().getUserByUID((val) {
        accountStream.add(val);
      });
      accountStateStream.add(UIState.SUCCESS);
    } catch (e) {
      accountStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }

  // Get image from library
  void getImageByGallery(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      File file = File(pickedFile!.path);
      fileIamgeStream.add(file);
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Get image from camera
  void getImageByCamera(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      File file = File(pickedFile!.path);
      fileIamgeStream.add(file);
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Update avatar account
  void updateImageAvatar(File file) async {
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('${Path.basename(file.path)}}');
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FireAuth().updateAvatar(val);
        });
      });
      _getAccount();
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Update information account
  void updateInfoAccount(String name, String phone, String pass) {
    try {
      FireAuth().updateInfoAccount(name, phone);
      if (pass != '') {
        FireAuth().updatePassword(pass);
      }
      _getAccount();
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }
}
