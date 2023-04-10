// ignore_for_file: deprecated_member_use, library_prefixes

import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '/components/components.dart';
import '../../fire_auth/fire_auth.dart';

class NewHotelBloc extends BaseBloc {
  BehaviorSubject<UIState> newHotelStateStream = BehaviorSubject();
  BehaviorSubject<File> fileImageStream = BehaviorSubject();

  @override
  void init() {
    getMyHotel();
  }

  @override
  void dispose() {
    newHotelStateStream.close();
    fileImageStream.close();
  }

  // Get Hotel
  void getMyHotel() async {
    try {
      newHotelStateStream.add(UIState.LOADING);
      FireAuth().getHotel((val) {});
      newHotelStateStream.add(UIState.SUCCESS);
    } catch (e) {
      newHotelStateStream.add(UIState.ERROR);
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

  // Add Hotel
  void addHotel(File file, String name, String phone, String bankName,
      String bankNumber, String accountName) async {
    newHotelStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child(Path.basename(file.path));
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FireAuth().createMyHotel(
              val, name, phone, bankName, bankNumber, accountName, () {
            newHotelStateStream.add(UIState.SUCCESS);
            FlutterToast().showToast("Success");
          }, (val) {
            newHotelStateStream.add(UIState.ERROR);
            FlutterToast().showToast(val);
          });
        });
      });
    } catch (e) {
      newHotelStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }
}
