// ignore_for_file: avoid_print

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../my_hotel.dart';
import '/ui/ui.dart';
import '/model/model.dart';
import '/utils/utils.dart';
import '/components/components.dart';

class EditHotel extends StatefulWidget {
  final MyHotel myHotel;

  const EditHotel({super.key, required this.myHotel});

  @override
  State<EditHotel> createState() => _EditHotelState();
}

class _EditHotelState extends State<EditHotel> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late final File file;
  late final ThemeData themeData;
  late final TextEditingController controllerName;
  late final TextEditingController controllerPhone;
  late final TextEditingController controllerBankName;
  late final TextEditingController controllerNumberBank;
  late final TextEditingController controllerAccountBankName;
  late final EditHotelBloc editHotelBloc;

  @override
  void initState() {
    super.initState();
    editHotelBloc = EditHotelBloc();
    controllerPhone = TextEditingController(text: widget.myHotel.phone);
    controllerName = TextEditingController(text: widget.myHotel.name);
    controllerBankName = TextEditingController(text: widget.myHotel.bankName);
    controllerNumberBank =
        TextEditingController(text: widget.myHotel.bankNumber);
    controllerAccountBankName =
        TextEditingController(text: widget.myHotel.accountNameBank);
  }

  @override
  void dispose() {
    super.dispose();
    editHotelBloc.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    editHotelBloc.editHotelStateStream.listen((value) {
      if (value == UIState.SUCCESS) {
        Navigator.pop(context);
      }
    });
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
          'Edit Home Stay '.toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete, color: AppColors.primaryColor),
              onPressed: () {
                editHotelBloc.deleteHotel();
              }),
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
                    GestureDetector(
                      onTap: () {
                        showGetImage(context);
                      },
                      child: StreamBuilder<File>(
                        stream: editHotelBloc.fileImageStream,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            file = snapshot.data!;
                            return Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                  image: FileImage(snapshot.data!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          } else {
                            return Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(widget.myHotel.urlImage),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Name ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      controller: controllerName,
                      hintText: 'Input Name of Home Stay ',
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.home_filled,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Contact ',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      controller: controllerPhone,
                      hintText: 'Input Phone Number of Home Stay ',
                      keyboardType: TextInputType.phone,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.smartphone_rounded,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 35),
                    Center(
                      child: Text(
                        'Account Bank '.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Center(
                      child: SizedBox(
                        width: 200,
                        child: Divider(
                          height: 2,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Bank Name '.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      hintText: 'Input Name of Bank ',
                      controller: controllerBankName,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.comment_bank,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Bank Account Number '.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ReuseduceTextFormField(
                      controller: controllerNumberBank,
                      hintText: 'Input Number of Bank Account ',
                      keyboardType: TextInputType.phone,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.confirmation_number,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Bank Account Name '.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      controller: controllerAccountBankName,
                      hintText: 'Input Name of Bank Account ',
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.perm_contact_cal,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
            stream: editHotelBloc.editHotelStateStream,
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
          title: 'Update',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              try {
                if (file == null) {
                  editHotelBloc.editHotelNotFile(
                    widget.myHotel.urlImage,
                    controllerName.text,
                    controllerPhone.text,
                    controllerBankName.text,
                    controllerNumberBank.text,
                    controllerAccountBankName.text,
                  );
                } else {
                  editHotelBloc.editHotelHaveFile(
                    file,
                    controllerName.text,
                    controllerPhone.text,
                    controllerBankName.text,
                    controllerNumberBank.text,
                    controllerAccountBankName.text,
                  );
                }
              } catch (e) {
                print(e);
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
          width: double.infinity,
          height: 100,
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
                    title: 'Camera ',
                    onPressed: () {
                      editHotelBloc.getImageByCamera(picker);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ReuseduceButton(
                    title: 'Library ',
                    onPressed: () {
                      editHotelBloc.getImageByGallery(picker);
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
