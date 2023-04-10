// import 'package:flutter/material.dart';

// import '../ui/ui.dart';

// class XButton extends StatelessWidget {
//   final Color color;
//   final String title;
//   final double height;
//   final Function onTap;

//   const XButton({
//     super.key,
//     this.height = 55,
//     this.color = AppColors.primaryColor,
//     required this.title,
//     required this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onTap();
//       },
//       child: Container(
//         height: height,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         width: double.infinity,
//         child: Center(
//           child: Text(
//             title.toUpperCase(),
//             style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
//           ),
//         ),
//       ),
//     );
//   }
// }
