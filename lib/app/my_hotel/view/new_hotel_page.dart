import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '/ui/ui.dart';
import '../my_hotel.dart';
import '/utils/utils.dart';
import '/components/components.dart';

class NewHotel extends StatefulWidget {
  const NewHotel({super.key});

  @override
  State<NewHotel> createState() => _NewHotelState();
}

class _NewHotelState extends State<NewHotel> {
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  late final File file;
  late final ThemeData themeData;
  late final NewHotelBloc newHotelBloc;
  late final TextEditingController controllerName;
  late final TextEditingController controllerPhone;
  late final TextEditingController controllerBankName;
  late final TextEditingController controllerNumberBank;
  late final TextEditingController controllerAccountBankName;

  @override
  void initState() {
    super.initState();
    newHotelBloc = NewHotelBloc();
    controllerPhone = TextEditingController();
    controllerName = TextEditingController();
    controllerBankName = TextEditingController();
    controllerNumberBank = TextEditingController();
    controllerAccountBankName = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    newHotelBloc.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    newHotelBloc.newHotelStateStream.listen((value) {
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
          'New Home Stay'.toUpperCase(),
          style: TextStyle(
            color: themeData.textSelectionTheme.selectionColor,
            fontSize: 20,
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
                      stream: newHotelBloc.fileImageStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          file = snapshot.data!;
                          return Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              image: DecorationImage(
                                image: FileImage(
                                  snapshot.data!,
                                ),
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
                                  color: Colors.grey.withOpacity(.7), width: 2),
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
                    const SizedBox(height: 10),
                    const Text(
                      'Name',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      hintText: 'Input Name of Home Stay',
                      controller: controllerName,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.home_filled,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Contact',
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      controller: controllerPhone,
                      hintText: 'Input Phone Number of Home Stay',
                      keyboardType: TextInputType.phone,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.smartphone,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 35),
                    Center(
                      child: Text(
                        'Account Bank'.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 18,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w900,
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
                      'Bank Name'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      hintText: 'Input Name of Bank',
                      controller: controllerBankName,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.comment_bank,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Bank Account Number'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      hintText: 'Input Number of Bank Account',
                      controller: controllerNumberBank,
                      keyboardType: TextInputType.phone,
                      funcValidation: ValidateData.validEmpty,
                      prefixIcon: const Icon(
                        Icons.confirmation_number,
                        color: AppColors.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Bank Account Name'.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    ReuseduceTextFormField(
                      hintText: 'Input Name of Bank Account',
                      controller: controllerAccountBankName,
                      prefixIcon: const Icon(
                        Icons.perm_contact_cal,
                        color: AppColors.primaryColor,
                      ),
                      funcValidation: ValidateData.validEmpty,
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
          StreamBuilder<UIState>(
            stream: newHotelBloc.newHotelStateStream,
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
        padding: const EdgeInsets.fromLTRB(15, 5, 15, 20),
        child: ReuseduceButton(
          title: 'Save',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              newHotelBloc.addHotel(
                file,
                controllerName.text,
                controllerPhone.text,
                controllerBankName.text,
                controllerNumberBank.text,
                controllerAccountBankName.text,
              );
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
                      newHotelBloc.getImageByCamera(picker);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ReuseduceButton(
                    title: 'Library',
                    onPressed: () {
                      newHotelBloc.getImageByGallery(picker);
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
