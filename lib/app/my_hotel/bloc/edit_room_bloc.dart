// ignore_for_file: library_prefixes, deprecated_member_use

import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '/remote/remote.dart';
import '../../fire_auth/fire_auth.dart';
import '/components/components.dart';

class EditRoomBloc extends BaseBloc {
  BehaviorSubject<File> fileImageStream = BehaviorSubject();
  BehaviorSubject<UIState> editRoomStateStream = BehaviorSubject();
  BehaviorSubject<List<Province>> listProvinceStream = BehaviorSubject();

  @override
  void init() {
    _getProvince();
  }

  @override
  void dispose() {
    editRoomStateStream.close();
    fileImageStream.close();
    listProvinceStream.close();
  }

  void _getProvince() async {
    try {
      listProvinceStream.add([]);
      var tmp = await ManageRemote.provinceService.getAllProvince();
      listProvinceStream.add(tmp);
    } catch (e) {
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

  // Add room
  void addRoom(
    File file,
    String name,
    String startDay,
    String endDay,
    int adults,
    int child,
    String address,
    String city,
    String desc,
    int numberRoom,
    double price,
    double discount,
  ) async {
    editRoomStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('${Path.basename(file.path)}}');
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FireAuth().createNewRoom(val, name, startDay, endDay, adults, child,
              address, city, desc, price, discount, numberRoom, () {
            editRoomStateStream.add(UIState.SUCCESS);
            FlutterToast().showToast('Success');
          }, (va) {
            editRoomStateStream.add(UIState.ERROR);
            FlutterToast().showToast(va);
          });
        });
      });
    } catch (e) {
      editRoomStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }

  // Update room have image
  void updateRoomHaveFile(
    File file,
    int numberRoom,
    String id,
    String name,
    String startDay,
    String endDay,
    int adults,
    int child,
    String address,
    String city,
    String desc,
    double price,
    double discount,
  ) async {
    editRoomStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('${Path.basename(file.path)}}');
      await storageReference.putFile(file).then((val) {
        val.ref.getDownloadURL().then((val) {
          FireAuth().updateRoom(val, numberRoom, name, id, startDay, endDay,
              adults, child, address, city, desc, price, discount, () {
            editRoomStateStream.add(UIState.SUCCESS);
            FlutterToast().showToast('Success');
          }, (va) {
            editRoomStateStream.add(UIState.ERROR);
            FlutterToast().showToast(va);
          });
        });
      });
    } catch (e) {
      editRoomStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }

  // Update room not have image
  void updateRoomNotFile(
    int numberRoom,
    String urlImage,
    String id,
    String name,
    String startDay,
    String endDay,
    int adults,
    int child,
    String address,
    String city,
    String desc,
    double price,
    double discount,
  ) async {
    editRoomStateStream.add(UIState.LOADING);
    try {
      FireAuth().updateRoom(urlImage, numberRoom, name, id, startDay, endDay,
          adults, child, address, city, desc, price, discount, () {
        editRoomStateStream.add(UIState.SUCCESS);
        FlutterToast().showToast('Success');
      }, (va) {
        editRoomStateStream.add(UIState.ERROR);
        FlutterToast().showToast(va);
      });
    } catch (e) {
      editRoomStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }

  // Delete room by Id
  void deleteRoomById(String id) {
    try {
      editRoomStateStream.add(UIState.LOADING);
      FireAuth().deleteRoomById(id, () {
        editRoomStateStream.add(UIState.SUCCESS);
      }, () {
        editRoomStateStream.add(UIState.ERROR);
      });
    } catch (e) {
      FlutterToast().showToast(e.toString());
      editRoomStateStream.add(UIState.ERROR);
    }
  }
}
