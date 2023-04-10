// ignore_for_file: library_prefixes, deprecated_member_use

import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:rxdart/rxdart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../fire_auth/fire_auth.dart';
import '/components/components.dart';

class EditHotelBloc extends BaseBloc {
  BehaviorSubject<File> fileImageStream = BehaviorSubject();
  BehaviorSubject<UIState> editHotelStateStream = BehaviorSubject();

  @override
  void init() {
    getMyHotel();
  }

  @override
  void dispose() {
    editHotelStateStream.close();
    fileImageStream.close();
  }

  // Get list home stay
  void getMyHotel() async {
    try {
      editHotelStateStream.add(UIState.LOADING);
      FireAuth().getHotel((val) {});
      editHotelStateStream.add(UIState.SUCCESS);
    } catch (e) {
      editHotelStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }

  // Get image from library
  void getImageByGallery(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      File file = File(pickedFile!.path);
      fileImageStream.add(file);
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Get image from camera
  void getImageByCamera(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      File file = File(pickedFile!.path);
      fileImageStream.add(file);
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Edit hotel have image
  void editHotelHaveFile(File file, String name, String phone, String bankName,
      String bankNumber, String accountName) async {
    editHotelStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child(Path.basename(file.path));
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FireAuth().updateMyHotel(
              val, name, phone, bankName, bankNumber, accountName, () {
            editHotelStateStream.add(UIState.SUCCESS);
            FlutterToast().showToast("Success");
          }, (val) {
            editHotelStateStream.add(UIState.ERROR);
            FlutterToast().showToast(val);
          });
        });
      });
    } catch (e) {
      editHotelStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }

  ///Edit hotel don't have image
  void editHotelNotFile(String urlImage, String name, String phone,
      String bankName, String bankNumber, String accountName) async {
    editHotelStateStream.add(UIState.LOADING);
    try {
      FireAuth().updateMyHotel(
          urlImage, name, phone, bankName, bankNumber, accountName, () {
        editHotelStateStream.add(UIState.SUCCESS);
        FlutterToast().showToast("Success");
      }, (val) {
        editHotelStateStream.add(UIState.ERROR);
        FlutterToast().showToast(val);
      });
    } catch (e) {
      editHotelStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }

  // Delete hotel
  void deleteHotel() async {
    editHotelStateStream.add(UIState.LOADING);
    try {
      FireAuth().deleteMyHotel(() {
        editHotelStateStream.add(UIState.SUCCESS);
        FlutterToast().showToast("Success");
      }, () {
        editHotelStateStream.add(UIState.ERROR);
      });
    } catch (e) {
      editHotelStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }
}
