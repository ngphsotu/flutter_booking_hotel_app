// ignore_for_file: library_prefixes, deprecated_member_use

import 'dart:io';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as Path;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../components/components.dart';
import '../../../remote/remote.dart';
import '../../fire_auth/fire_auth.dart';

class NewRoomBloc extends BaseBloc {
  BehaviorSubject<UIState> newRoomStateStream = BehaviorSubject();
  BehaviorSubject<File> fileImageStream = BehaviorSubject();
  BehaviorSubject<List<Province>> listProvinceStream = BehaviorSubject();

  @override
  void init() {
    _getProvince();
  }

  @override
  void dispose() {
    newRoomStateStream.close();
    fileImageStream.close();
    listProvinceStream.close();
  }

  ///Get image from library
  void getImageByGallery(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      File file = File(pickedFile!.path);
      fileImageStream.add(file);
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  ///Get image from camera
  void getImageByCamera(ImagePicker picker) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      File file = File(pickedFile!.path);
      fileImageStream.add(file);
    } catch (e) {
      FlutterToast().showToast(e.toString());
    }
  }

  // Get list city
  void _getProvince() async {
    try {
      listProvinceStream.add([]);
      var tmp = await ManageRemote.provinceService.getAllProvince();
      listProvinceStream.add(tmp);
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
    int numberRoom,
    String address,
    String city,
    String desc,
    double price,
    double discount,
  ) async {
    newRoomStateStream.add(UIState.LOADING);
    try {
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference storageReference =
          storage.ref().child('${Path.basename(file.path)}}');
      await storageReference.putFile(file).then(
        (val) {
          val.ref.getDownloadURL().then((val) {
            FireAuth().createNewRoom(val, name, startDay, endDay, adults, child,
                address, city, desc, price, discount, numberRoom, () {
              newRoomStateStream.add(UIState.SUCCESS);
              FlutterToast().showToast("Success");
            }, (va) {
              newRoomStateStream.add(UIState.ERROR);
              FlutterToast().showToast(va);
            });
          });
        },
      );
    } catch (e) {
      newRoomStateStream.add(UIState.ERROR);
      FlutterToast().showToast(e.toString());
    }
  }
}
