import 'package:flutter/material.dart';

class ReuseduceButton extends StatefulWidget {
  final Color? color;
  final Widget? child;
  final String? title;
  final double? height;
  final Function onPressed;
  // final bool autofocus = false;
  // final Clip clipBehavior = Clip.none;
  // final ButtonStyle? style;
  // final String? title;
  // final FocusNode? focusNode;
  // final Function()? onLongPress;
  // final Function(bool)? onHover;
  // final Function(bool)? onFocusChange;
  // final MaterialStatesController? statesController;

  const ReuseduceButton({
    super.key,
    this.height = 55,
    this.color,
    this.child,
    this.title,
    required this.onPressed,
  });

  @override
  State<ReuseduceButton> createState() => _ReuseduceButtonState();
}

class _ReuseduceButtonState extends State<ReuseduceButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
      },
      child: widget.child,
    );
  }
}

 
/*
import 'package:flutter/material.dart';

import '../ui/ui.dart';

class XButton extends StatelessWidget {
  final Color color;
  final String title;
  final double height;
  final Function onTap;

  const XButton({
    super.key,
    this.height = 55,
    this.color = AppColors.primaryColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        child: Center(
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}

*/