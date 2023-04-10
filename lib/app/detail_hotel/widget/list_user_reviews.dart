import 'package:flutter/material.dart';

import '/ui/ui.dart';

class ListUserReviews extends StatelessWidget {
  ListUserReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: double.infinity,
      child: Stack(
        children: list.map((e) {
          return list.indexOf(e) < 5
              ? Positioned(
                  left: list.indexOf(e) * 15.0,
                  child: itemUser(),
                )
              : list.indexOf(e) == 5
                  ? Positioned(
                      left: list.indexOf(e) * 15.0,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primaryColor,
                        ),
                        child: Center(
                          child: Text(
                            '${list.length - 5}+',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox();
        }).toList(),
      ),
    );
  }

  Widget itemUser() {
    return Container(
      width: 30,
      height: 30,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/images/travel.png'),
        ),
      ),
    );
  }

  List<int> list = [1, 23, 3, 4, 45, 4, 3, 2];
}
