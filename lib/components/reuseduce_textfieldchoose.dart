// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/ui/ui.dart';
import 'components.dart';
import '/utils/utils.dart';
import '../model/model.dart';

class ReuseduceTextFieldChoose extends StatefulWidget {
  final String hintText;
  final String? intiText;
  final IconData iconData;
  final Function callBack;
  final List<ItemModel> items;

  const ReuseduceTextFieldChoose({
    super.key,
    this.intiText,
    required this.items,
    required this.iconData,
    required this.hintText,
    required this.callBack,
  });

  @override
  State<ReuseduceTextFieldChoose> createState() =>
      _ReuseduceTextFieldChooseState();
}

class _ReuseduceTextFieldChooseState extends State<ReuseduceTextFieldChoose> {
  int _index = -1;
  late final ThemeData themeData;
  late final TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController(text: widget.intiText);
    if (widget.intiText != null) {
      for (var element in widget.items) {
        if (element.name == widget.intiText) {
          _index = widget.items.indexOf(element);
        }
      }
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    themeData = Provider.of<ThemeChanger>(context).getTheme();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ReuseduceTextFormField(
          controller: controller,
          hintText: widget.hintText,
          funcValidation: ValidateData.validEmpty,
          prefixIcon: Icon(
            widget.iconData,
            color: AppColors.primaryColor,
          ),
          suffixIcon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.primaryColor,
          ),
        ),
        GestureDetector(
          onTap: () {
            showModalItem();
          },
          child: Container(
            height: 55,
            color: AppColors.transparent,
            width: double.infinity,
          ),
        )
      ],
    );
  }

  void showModalItem() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Center(
        child: Container(
          width: 250,
          height: 12.0 * widget.items.length,
          constraints: const BoxConstraints(minHeight: 200, maxHeight: 500),
          decoration: BoxDecoration(
            color: themeData.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: widget.items.isNotEmpty
                ? ListView.builder(
                    itemCount: widget.items.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 7),
                        child: GestureDetector(
                          onTap: () {
                            _index = i;
                            controller.text = widget.items[i].name;
                            widget.callBack(widget.items[i].name);
                            Navigator.pop(context);
                          },
                          child: Text(
                            widget.items[i].name,
                            style: TextStyle(
                              color: _index == i
                                  ? AppColors.primaryColor
                                  : themeData.textSelectionTheme.selectionColor,
                              fontWeight: _index == i
                                  ? FontWeight.w800
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : const NoFoundWidget(title: 'No data'),
          ),
        ),
      ),
    );
  }
}
