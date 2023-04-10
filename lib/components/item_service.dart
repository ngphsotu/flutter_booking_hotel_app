import 'package:flutter/material.dart';

class ItemService extends StatelessWidget {
  final Widget widget;
  final String title;

  const ItemService({super.key, required this.title, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          widget,
          const SizedBox(height: 5),
          Text(
            title,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}
