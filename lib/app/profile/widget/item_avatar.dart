import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '/ui/ui.dart';
import '../profile.dart';
import '/components/components.dart';

class ItemAvatar extends StatelessWidget {
  final Color color;
  final String avatar;
  final ProfileBloc profileBloc;
  final picker = ImagePicker();

  ItemAvatar(this.color, this.avatar, this.profileBloc, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //profileBloc.fileIamgeStream.add(null);
        showGetImage(context);
      },
      child: Container(
        width: 150,
        height: 150,
        margin: const EdgeInsets.only(top: 40),
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: color, width: 6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(avatar),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showGetImage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StreamBuilder<File>(
          stream: profileBloc.fileIamgeStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Image.file(
                          snapshot.data!,
                          fit: BoxFit.cover,
                          width: 200,
                          height: 200,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ReuseduceButton(
                        title: 'Save',
                        onPressed: () {
                          profileBloc.updateImageAvatar(snapshot.data!);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: ReuseduceButton(
                          title: 'Camera',
                          onPressed: () {
                            profileBloc.getImageByCamera(picker);
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ReuseduceButton(
                          title: 'Library',
                          onPressed: () {
                            profileBloc.getImageByGallery(picker);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
