// ignore_for_file: deprecated_member_use

import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

class ItemFunction extends StatelessWidget {
  final Color? color;
  final String title;
  final String urlSVG;
  final Function onTap;

  const ItemFunction({
    super.key,
    this.color,
    required this.title,
    required this.urlSVG,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SvgPicture.asset(urlSVG, width: 20, color: color),
                  const SizedBox(width: 15),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 16, letterSpacing: 1),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
