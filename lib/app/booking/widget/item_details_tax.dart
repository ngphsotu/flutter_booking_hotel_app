import 'package:flutter/material.dart';

import '/ui/ui.dart';

class ItemDetailsTax extends StatelessWidget {
  final bool isShowNumber;
  final int number;
  final String title;
  final double price;

  const ItemDetailsTax({
    super.key,
    this.isShowNumber = false,
    required this.number,
    required this.title,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
          ),
        ),
        Expanded(
          flex: 1,
          child: !isShowNumber
              ? const SizedBox()
              : Text(
                  'x$number',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            '${price * number}\$',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 17,
              color: price >= 0 ? null : AppColors.primaryColor.withOpacity(.6),
            ),
          ),
        ),
      ],
    );
  }
}
