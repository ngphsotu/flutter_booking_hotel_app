import 'package:flutter/material.dart';

class TextAndButton extends StatelessWidget {
  final String textalready;
  final String textbutton;
  final Function? onpressed;

  const TextAndButton({
    super.key,
    required this.textalready,
    required this.textbutton,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textalready),
        const SizedBox(width: 5),
        TextButton(
          onPressed: () {
            onpressed!();
          },
          child: Text(textbutton.toUpperCase()),
        ),
      ],
    );
  }
}
