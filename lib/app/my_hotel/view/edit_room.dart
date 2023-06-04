// ignore_for_file: avoid_print, import_of_legacy_library_into_null_safe, library_prefixes

import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '/ui/ui.dart';
import '../my_hotel.dart';
import '/model/model.dart';
import '/utils/utils.dart';
import '/remote/remote.dart';
import '/components/components.dart';

class EditRoomPage extends StatefulWidget {
  final Room room;

  const EditRoomPage({super.key, required this.room});

  @override
  State<EditRoomPage> createState() => _EditRoomState();
}

class _EditRoomState extends State<EditRoomPage> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late final int child;
  late final int adults;
  late final int numberRoom;
  late final File file;
  late final String endDay;
  late final String startDay;
  late final ThemeData themeData;
  late final EditRoomBloc editRoomBloc;
  late final TextEditingController controllerName;
  late final TextEditingController controllerDesc;
  late final TextEditingController controllerAddress;
  late final TextEditingController controllerFreeTime;
  late final TextEditingController controllerCity;
  late final TextEditingController controllerPrice;
  late final TextEditingController controllerDiscountPercent;

  @override
  void initState() {
    super.initState();
    child = widget.room.numberChild;
    adults = widget.room.numberAdults;
    startDay = widget.room.startDay;
    endDay = widget.room.endDay;
    numberRoom = widget.room.numberRoom;
    editRoomBloc = EditRoomBloc()..init();
    controllerName = TextEditingController(text: widget.room.nameRoom);
    controllerDiscountPercent =
        TextEditingController(text: widget.room.discount.toString());
    controllerPrice = TextEditingController(text: widget.room.money.toString());
    controllerCity = TextEditingController(text: widget.room.city);
    controllerDesc = TextEditingController(text: widget.room.desc);
    controllerAddress = TextEditingController(text: widget.room.address);
    controllerFreeTime = TextEditingController(
        text:
            '${DateTime.parse(widget.room.startDay).day}/${DateTime.parse(widget.room.startDay).month} - ${DateTime.parse(widget.room.endDay).day}/${DateTime.parse(widget.room.endDay).month}/${DateTime.parse(widget.room.endDay).year}');
  }

  @override
  void dispose() {
    super.dispose();
    editRoomBloc.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    editRoomBloc.editRoomStateStream.listen(
      (value) {
        if (value == UIState.SUCCESS) {
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        titleSpacing: 1,
        backgroundColor: themeData.scaffoldBackgroundColor,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.arrow_back_ios,
              size: 15,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        title: Text(
          'Edit Room'.toUpperCase(),
          style: TextStyle(
            color: themeData.textSelectionTheme.selectionColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: AppColors.primaryColor),
            onPressed: () {
              editRoomBloc.deleteRoomById(widget.room.idRoom);
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder<File>(
                      stream: editRoomBloc.fileImageStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          file = snapshot.data!;
                          return Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(snapshot.data!),
                              ),
                            ),
                          );
                        } else {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  try {
                                    showGetImage(context);
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(widget.room.urlImage),
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.camera_alt,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'City',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    StreamBuilder<List<Province>>(
                      stream: editRoomBloc.listProvinceStream,
                      builder: (context, snapshot1) {
                        if (snapshot1.hasData) {
                          List<ItemModel> items = [];
                          for (var element in snapshot1.data!) {
                            items.add(
                              ItemModel(
                                id: element.code,
                                name: element.name,
                              ),
                            );
                          }
                          return ReuseduceTextFieldChoose(
                            items: items,
                            hintText: 'City',
                            iconData: Icons.location_on,
                            intiText: controllerCity.text,
                            callBack: (val) {
                              controllerCity.text = val;
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Room Name',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      hintText: 'Name of Room',
                      controller: controllerName,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.home_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Room Address',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      hintText: 'Address of Room',
                      controller: controllerAddress,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.map,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Room Description',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      maxLine: 4,
                      hintText: 'Description Something About Room',
                      controller: controllerDesc,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.note,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Room Price',
                                style: TextStyle(
                                  fontSize: 15,
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ReuseduceTextFormField(
                                hintText: '0',
                                controller: controllerPrice,
                                keyboardType: TextInputType.phone,
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: const Icon(
                                  Icons.local_atm,
                                  color: AppColors.primaryColor,
                                ),
                                suffixIcon: const SizedBox(
                                  width: 20,
                                  child: Center(
                                    child: Text(
                                      '\$',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Room Discount',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ReuseduceTextFormField(
                                hintText: '0',
                                controller: controllerDiscountPercent,
                                keyboardType: TextInputType.phone,
                                funcValidation: ValidateData.validEmpty,
                                prefixIcon: const Icon(
                                  Icons.money_off,
                                  size: 20,
                                  color: AppColors.primaryColor,
                                ),
                                suffixIcon: const SizedBox(
                                  width: 20,
                                  child: Center(
                                    child: Text(
                                      '%',
                                      style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Free Time',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () async {
                        DateTime? picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (picked != null) {
                          setState(() {
                            controllerFreeTime.text =
                                DateFormat('dd-MM-yyyy').format(picked);
                          });
                        }
                      },
                      child: ReuseduceTextFormField(
                        enable: false,
                        hintText: 'Free Time in Room',
                        controller: controllerFreeTime,
                        funcValidation: ValidateData.validEmpty,
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Rooms',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFieldChoose(
                      hintText: 'How Many Rooms ?',
                      iconData: Icons.room_preferences,
                      callBack: (val) {
                        numberRoom = int.parse(val);
                      },
                      items: [
                        ItemModel(id: '01', name: '01'),
                        ItemModel(id: '02', name: '02'),
                        ItemModel(id: '03', name: '03'),
                        ItemModel(id: '04', name: '04'),
                        ItemModel(id: '05', name: '05'),
                        ItemModel(id: '06', name: '06'),
                        ItemModel(id: '07', name: '07'),
                        ItemModel(id: '08', name: '08'),
                        ItemModel(id: '09', name: '09'),
                        ItemModel(id: '10', name: '10'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Adults',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFieldChoose(
                      hintText: 'How Many Adults ?',
                      iconData: Icons.people,
                      callBack: (val) {
                        adults = int.parse(val);
                      },
                      items: [
                        ItemModel(id: '01', name: '01'),
                        ItemModel(id: '02', name: '02'),
                        ItemModel(id: '03', name: '03'),
                        ItemModel(id: '04', name: '04'),
                        ItemModel(id: '05', name: '05'),
                        ItemModel(id: '06', name: '06'),
                        ItemModel(id: '07', name: '07'),
                        ItemModel(id: '08', name: '08'),
                        ItemModel(id: '09', name: '09'),
                        ItemModel(id: '10', name: '10'),
                        ItemModel(id: '11', name: '11'),
                        ItemModel(id: '12', name: '12'),
                        ItemModel(id: '13', name: '13'),
                        ItemModel(id: '14', name: '14'),
                        ItemModel(id: '15', name: '15'),
                        ItemModel(id: '16', name: '16'),
                        ItemModel(id: '17', name: '17'),
                        ItemModel(id: '18', name: '18'),
                        ItemModel(id: '19', name: '19'),
                        ItemModel(id: '20', name: '20'),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Children',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFieldChoose(
                      hintText: 'How Many Children ?',
                      iconData: Icons.emoji_people,
                      callBack: (val) {
                        child = int.parse(val);
                      },
                      items: [
                        ItemModel(id: '00', name: '00'),
                        ItemModel(id: '01', name: '01'),
                        ItemModel(id: '02', name: '02'),
                        ItemModel(id: '03', name: '03'),
                        ItemModel(id: '04', name: '04'),
                        ItemModel(id: '05', name: '05'),
                        ItemModel(id: '06', name: '06'),
                        ItemModel(id: '07', name: '07'),
                        ItemModel(id: '08', name: '08'),
                        ItemModel(id: '09', name: '09'),
                        ItemModel(id: '10', name: '10'),
                        ItemModel(id: '11', name: '11'),
                        ItemModel(id: '12', name: '12'),
                        ItemModel(id: '13', name: '13'),
                        ItemModel(id: '14', name: '14'),
                        ItemModel(id: '15', name: '15'),
                        ItemModel(id: '16', name: '16'),
                        ItemModel(id: '17', name: '17'),
                        ItemModel(id: '18', name: '18'),
                        ItemModel(id: '19', name: '19'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
            stream: editRoomBloc.editRoomStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING) {
                return const LoadingBar();
              } else {
                return const Center();
              }
            },
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(50, 5, 50, 20),
        child: ReuseduceButton(
          title: 'Update Information Room',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              try {
                if (file == null) {
                  editRoomBloc.updateRoomNotFile(
                    numberRoom,
                    widget.room.urlImage,
                    widget.room.idRoom,
                    controllerName.text,
                    startDay,
                    endDay,
                    adults,
                    child,
                    controllerAddress.text,
                    controllerCity.text,
                    controllerDesc.text,
                    double.parse(controllerPrice.text),
                    double.parse(controllerDiscountPercent.text),
                  );
                } else {
                  editRoomBloc.updateRoomHaveFile(
                    file,
                    numberRoom,
                    widget.room.idRoom,
                    controllerName.text,
                    startDay,
                    endDay,
                    adults,
                    child,
                    controllerAddress.text,
                    controllerCity.text,
                    controllerDesc.text,
                    double.parse(controllerPrice.text),
                    double.parse(controllerDiscountPercent.text),
                  );
                }
              } catch (e) {
                FlutterToast().showToast(e.toString());
              }
            }
          },
        ),
      ),
    );
  }

  void showGetImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: themeData.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Expanded(
                  child: ReuseduceButton(
                      title: 'Camera',
                      onPressed: () {
                        editRoomBloc.getImageByCamera(picker);
                      }),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ReuseduceButton(
                    title: 'Library',
                    onPressed: () {
                      editRoomBloc.getImageByGallery(picker);
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
