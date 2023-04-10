// ignore_for_file: import_of_legacy_library_into_null_safe, library_prefixes

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRagePicker;

import '/ui/ui.dart';
import '../my_hotel.dart';
import '/model/model.dart';
import '/utils/utils.dart';
import '/remote/remote.dart';
import '/components/components.dart';

class NewRoom extends StatefulWidget {
  const NewRoom({super.key});

  @override
  State<NewRoom> createState() => _NewRoomState();
}

class _NewRoomState extends State<NewRoom> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late final int child;
  late final int adults;
  late final int numberRoom;
  late final int startDay;
  late final int endDay;
  late final File file;
  late final ThemeData themeData;
  late final NewRoomBloc newRoomBloc;
  late final TextEditingController controllerName;
  late final TextEditingController controllerDesc;
  late final TextEditingController controllerAddress;
  late final TextEditingController controllerFreeTime;
  late final TextEditingController controllerCity;
  late final TextEditingController controllerPrice;
  late final TextEditingController controllerDiscountPercent;

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    newRoomBloc.newRoomStateStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pop(context);
      }
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    startDay = DateTime.now().toIso8601String() as int;
    endDay = DateTime.now().toIso8601String() as int;
    newRoomBloc = NewRoomBloc()..init();
    controllerName = TextEditingController();
    controllerDiscountPercent = TextEditingController();
    controllerPrice = TextEditingController();
    controllerCity = TextEditingController();
    controllerDesc = TextEditingController();
    controllerAddress = TextEditingController();
    controllerFreeTime = TextEditingController();
  }

  @override
  void dispose() {
    newRoomBloc.dispose();
    super.dispose();
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
          'Create New Room'.toUpperCase(),
          style: TextStyle(
            fontSize: 20,
            color: themeData.textSelectionTheme.selectionColor,
            fontWeight: FontWeight.bold,
          ),
        ),
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
                      stream: newRoomBloc.fileImageStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          file = snapshot.data!;
                          return Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                image: FileImage(snapshot.data!),
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(
                                width: 2,
                                color: Colors.grey.withOpacity(.7),
                              ),
                            ),
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  showGetImage(context);
                                },
                                child: Icon(
                                  Icons.image,
                                  size: 200,
                                  color: Colors.grey.withOpacity(.7),
                                ),
                              ),
                            ),
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
                      stream: newRoomBloc.listProvinceStream,
                      builder: (context, snapshot1) {
                        if (snapshot1.hasData) {
                          List<ItemModel> items = [];
                          for (var element in snapshot1.data!) {
                            items.add(ItemModel(
                              id: element.code,
                              name: element.name,
                            ));
                          }
                          return ReuseduceTextFieldChoose(
                            items: items,
                            hintText: 'City',
                            iconData: Icons.location_on,
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
                      hintText: 'Input Name of Room',
                      controller: controllerName,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.home_work,
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
                      hintText: 'Input Address of Room',
                      controller: controllerAddress,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.home_rounded,
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
                      hintText: 'Input Description of Room',
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
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
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
                                  //Text size
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ReuseduceTextFormField(
                                controller: controllerDiscountPercent,
                                hintText: '0',
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
                    Stack(
                      children: [
                        ReuseduceTextFormField(
                          controller: controllerFreeTime,
                          hintText: 'Check In - Check Out',
                          funcValidation: ValidateData.validEmpty,
                          prefixIcon: const Icon(
                            Icons.calendar_today,
                            color: AppColors.primaryColor,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final List<DateTime> picked =
                                await DateRagePicker.showDatePicker(
                              context: context,
                              initialFirstDate: DateTime.now(),
                              initialLastDate:
                                  (DateTime.now()).add(const Duration(days: 7)),
                              firstDate: DateTime(2015),
                              lastDate: DateTime(2025),
                            );
                            if (picked.length == 2) {
                              startDay = picked[0].toIso8601String() as int;
                              endDay = picked[1].toIso8601String() as int;
                              controllerFreeTime.text =
                                  '${picked[0].day}/${picked[0].month}-${picked[1].day}/${picked[1].month}/${picked[0].year}';
                            }
                          },
                          child: Container(
                            color: Colors.transparent,
                            width: double.infinity,
                            height: 55,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        final List<DateTime> picked =
                            await DateRagePicker.showDatePicker(
                                context: context,
                                initialFirstDate: DateTime.now(),
                                initialLastDate: (DateTime.now())
                                    .add(const Duration(days: 7)),
                                firstDate: DateTime(2015),
                                lastDate: DateTime(2025));

                        if (picked.length == 2) {
                          startDay = picked[0].toIso8601String() as int;
                          endDay = picked[1].toIso8601String() as int;
                          controllerFreeTime.text =
                              '${picked[0].day}/${picked[0].month}-${picked[1].day}/${picked[1].month}/${picked[0].year}';
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
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFieldChoose(
                      iconData: Icons.room_preferences,
                      hintText: 'How Many Rooms ?',
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
                      iconData: Icons.people,
                      hintText: 'How Many Adults ?',
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
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFieldChoose(
                      iconData: Icons.emoji_people,
                      hintText: 'How Many Children ?',
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
            stream: newRoomBloc.newRoomStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == UIState.LOADING) {
                return const LoadingBar();
              } else {
                return const Center();
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
        child: ReuseduceButton(
          title: 'Save',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              try {
                newRoomBloc.addRoom(
                  file,
                  controllerName.text,
                  startDay as String,
                  endDay as String,
                  adults,
                  child,
                  numberRoom,
                  controllerAddress.text,
                  controllerCity.text,
                  controllerDesc.text,
                  double.parse(controllerPrice.text),
                  double.parse(controllerDiscountPercent.text),
                );
              } catch (e) {
                FlutterToast().showToast(e.toString());
              }
            }
          },
        ),
      ),
    );
  }

  // Show Get Image
  void showGetImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
                      newRoomBloc.getImageByCamera(picker);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ReuseduceButton(
                    title: 'Library',
                    onPressed: () {
                      newRoomBloc.getImageByGallery(picker);
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
