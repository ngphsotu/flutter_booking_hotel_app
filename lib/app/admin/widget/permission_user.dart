import 'package:flutter/material.dart';

import '/ui/ui.dart';
import '../admin.dart';
import '/model/model.dart';
import '/components/components.dart';

class PermissionUser extends StatefulWidget {
  final Account account;
  final AdminBloc? adminBloc;

  const PermissionUser({
    super.key,
    required this.account,
    this.adminBloc,
  });

  @override
  State<PermissionUser> createState() => _PermissionUserState();
}

class _PermissionUserState extends State<PermissionUser> {
  late int isActive;
  late int permission;
  late ItemModel initItem;

  @override
  void initState() {
    super.initState();
    isActive = widget.account.isActive;
    permission = widget.account.permission;
    if (permission == 1) {
      initItem = ItemModel(id: '1', name: 'User');
    } else {
      initItem = ItemModel(id: '0', name: 'Admin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            height: 50,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: const Center(
              child: Text(
                'Permission',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Permission user',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ItemActiveUser(
                    title: 'Active user',
                    initVal: widget.account.permission,
                    callBack: (val) {
                      if (val) {
                        permission = 1;
                      } else {
                        permission = 0;
                      }
                    },
                  ),
                  const SizedBox(height: 15),
                  ReuseduceButton(
                    title: 'Save',
                    height: 50,
                    onPressed: () {
                      widget.adminBloc!
                          .updatePermission(widget.account.uid, permission);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
