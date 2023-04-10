import 'package:flutter/cupertino.dart';

import '/ui/ui.dart';

class ItemActiveUser extends StatefulWidget {
  final int initVal;
  final String title;
  final Function callBack;

  const ItemActiveUser({
    super.key,
    required this.title,
    required this.initVal,
    required this.callBack,
  });

  @override
  State<ItemActiveUser> createState() => _ItemActiveUserState();
}

class _ItemActiveUserState extends State<ItemActiveUser> {
  late bool isActive;

  @override
  void initState() {
    super.initState();
    if (widget.initVal == 1) {
      isActive = true;
    } else {
      isActive = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "User",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        const SizedBox(width: 20),
        CupertinoSwitch(
          activeColor: AppColors.primaryColor,
          value: isActive,
          onChanged: (i) {
            setState(() {
              isActive = i;
            });
            widget.callBack(i);
          },
        ),
        const SizedBox(width: 20),
        const Text(
          "Admin",
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
